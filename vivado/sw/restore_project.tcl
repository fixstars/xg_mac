set design_name [lindex $argv 0]
set xsa_path   [lindex $argv 1]
set source_path [lindex $argv 2]

set platform_project  ${design_name}_hw
set app_project ${design_name}

setws .
platform create -name ${platform_project} -hw ${xsa_path} -prebuilt -proc microblaze_0 -os standalone
app create -name ${app_project} -platform ${platform_project} -proc microblaze_0 -os standalone -lang c++ -template {Empty application} 
importsources -name ${app_project} -path ${source_path}

app build -name ${app_project}
