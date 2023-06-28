#ssh into termux
export def ssh-termux [ip?] {
  let ip = if ($ip | is-empty) {$env.MY_ENV_VARS.termux_ip} else {$ip}
  ssh -X -p 5699 $ip -i ~/.ssh/id_rsa_termux
}

#ssh to known devices
export def ssh-to [
  --user(-u) = "kira"
  --port(-p) = 5699
  --ubb(-u)
  --ubb_max(-m)
] {
  let ip = (
    if $ubb {
      open "~/Yandex.Disk/Android Devices/Apps/Termux/ips_ubb.json"
    } else if $ubb_max {
      open "~/Yandex.Disk/Android Devices/Apps/Termux/ips_ubb_max.json"
    } else {
      open "~/Yandex.Disk/Android Devices/Apps/Termux/ips_deathnote.json"
    } 
    | get internal
  )

  print (echo-g $"connecting to ($ip)...")
  ssh -X -p $port $"($user)@($ip)"
}

#backup webies 2 drive
export def copy-webies-2-ubbdrive [] {
  let mounted = ("~/gdrive/Sites/webies" | path expand | path exists)

  if not $mounted {
    print (echo-g "mounting gdrive...")
    mount-ubb
  }
  
  print (echo-g "syncing...")
  rsync -urta --progress -e "ssh -p 22 -i /home/kira/.ssh/id_rsa" ing_estadistica@146.83.193.197:/home/departamentos/ing_estadistica/public_html/ /home/kira/gdrive/Sites/webies/
}

#backup yandex-research to gdrive
export def copy-research-2-ubbdrive [
  source_dir? = "~/Yandex.Disk/Research"
  destination? = "~/gdrive/ResearchData"
] {

  let mounted = ($destination | path expand | path exists)

  if not $mounted {
    print (echo-g "mounting gdrive...")
    mount-ubb
  }
  
  print (echo-g "syncing...")
  rsync -urta --progress ($source_dir | path expand) ($destination | path expand)
}

#http post to #announcements in discord
export def ubb_announce [message] {
  let content = $"{\"content\": \"($message)\"}"

  let weburl = (open-credential ([$env.MY_ENV_VARS.credentials "discord_webhooks.json.asc"] | path join) | get cursos_ubb_announce)

  http post $weburl $content --content-type "application/json"
}  

#upload weekly videos and http post to discord
export def up2ubb [year = 2022, sem = 02] {
  let sem = ([($year | into string) "-" ($sem | into string | fill -a r -c "0" -w 2)] | str join)

  let mounted = ("~/gdrive/VClasses/" | path expand | path exists)

  if not $mounted {
    print (echo-g "mounting gdrive...")
    mount-ubb
  }

  cd $env.MY_ENV_VARS.zoom

  ls **/* 
  | where name !~ done
  | where type == file 
  | where name =~ mp4 
  | get name 
  | par-each {|path| 
      $path 
      | parse "{date} {time} {course} {class}/{file}"
    } 
  | flatten 
  | each {|it| 
      let dir = ([$it.date $it.time $it.course $it.class] | str join " ")
      let file_from = ([$dir $it.file] | path join)
      let file_to = ([$dir $"($it.class).mp4"] | path join)
      let gdrive_to = (["~" "gdrive" "VClasses" $sem $it.course $"($it.class).mp4"] 
        | path join 
        | path expand
      )
      
      if $file_from != $file_to {
        print (echo-g $"moving ($file_from) to ($file_to)...")
        mv $"($file_from)" $"($file_to)" | ignore
      }

      print (echo-g $"copying ($file_to) to ($gdrive_to)...")
      cp ($file_to) ($gdrive_to) | ignore  
    }
  
  let fecha = (date now | date format %d/%m/%y)
  let message = $"Se han subido a drive los videos de clases al dia de hoy: ($fecha)."

  ubb_announce $message 

  mv "20*" done
}

#http post to #medicos in discord
export def med_discord [message] {
  let content = $"{\"content\": \"($message).\"}"

  let weburl = (open-credential ([$env.MY_ENV_VARS.credentials "discord_webhooks.json.asc"] | path join) | get medicos)

  http post $weburl $content --content-type "application/json"
}  

#format emails from intranet
export def format-mails [
  mails:string #; separated email list
  #
  #Obtained from send email in intranet
] {
  $mails | str replace -a ';' ',' | copy
}

#move manga folder to Seagate External Drive
export def-env mvmanga [] {
  let from = $env.MY_ENV_VARS.local_manga
  let to = $env.MY_ENV_VARS.external_manga

  let dirs = (get-dirs $from)

  let file_count = (
    $dirs
    | each {|dir| 
        ls $dir.name 
        | length
      } 
    | wrap file_count
  )

  $dirs 
  | merge $file_count
  | where file_count < 5  
  | rm-pipe
  
  if (is-mounted "Seagate") {
    cd $from
    7z folders
    mv *.7z $to
  } else {
    return-error "Seageate drive isn't mounted"
  }
}

#update boletas honorarios
export def bhe-update [] {
  cd ~/Dropbox/Aplicaciones/Gmail

  ls
  | find bhe 
  | find 16061233 
  | mv-pipe "~/Dropbox/Documentos/Atemporales/Boletas Honorarios/"

  print (echo-g "compressing into boletas.7z...")
  cd "~/Dropbox/Documentos/Atemporales/Boletas Honorarios/"
  7z max boletas.7z bhe* -d 
}

#get ubb payment date 
export def "ubb pay" [] {
    http get http://www.ubiobio.cl/w/Calendario_de_Pagos/ 
    | query web -q "tbody" 
    | str replace -a "\t" "" 
    | str replace -a "\n\n" "#" 
    | str replace -a "##" "\n" 
    | str replace -a "#$" "" 
    | to text 
    | lines 
    | drop nth 0 1 
    | parse "{mes}#{fecha}"
}

#get ubb calendar
export def "ubb calendar" [
  semestre = 1 #1 (default) or 2
] {
  http get "http://www.ubiobio.cl/w/Calendario_Academico/" 
  | query web -q table 
  | get $semestre 
  | lines 
  | str trim 
  | str join "|" 
  | str replace  '|||' "\n" -a -s 
  | str replace '||' '' -s
  | str trim 
  | lines 
  | split column '|:|' 
  | rename Evento Fecha
}