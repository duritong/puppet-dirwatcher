# watch_events: Example: create,move_to
define dirwatcher::snippet(
  $ensure = 'present',
  $watch_directory,
  $watch_events,
  $watch_command,
  $watch_recursive = true,
  $watch_autoadd = true,
){
  if $ensure == 'present' {
    include ::dirwatcher
  }
  concat::fragment{$name:
    ensure => $ensure,
    content => template('dirwatcher/watcher_job.erb'),
    order => 200,
    target => "/etc/watcher.ini",
  }
}
