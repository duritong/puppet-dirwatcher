# watch_events: Example: create,move_to
define dirwatcher::job(
  $watch_directory,
  $watch_events,
  $watch_command,
  $watch_recursive = true,
  $watch_autoadd = true
){
  include ::dirwatcher
  concat::fragment{$name:
    content => template('dirwatcher/watcher_job.erb'),
    order   => 200,
    target  => '/etc/watcher.ini',
  }
}
