define bacula::config::client (
   $fileset  = 'Basic:noHome',
   $schedule = 'WeeklyCycle',
   $template = 'bacula/client_config.erb',
 ) {

 if ! is_domain_name("${name}") {
   fail "Name for client ${name} must be a fully qualified domain name"
 }

 $name_array = split($name, '[.]')
 $hostname   = $name_array[0]

 file { "/etc/bacula/bacula-dir.d/${name}.conf":
   ensure  => file,
   content => template($template),
   notify  => Service['bacula-director'],
 }
}
