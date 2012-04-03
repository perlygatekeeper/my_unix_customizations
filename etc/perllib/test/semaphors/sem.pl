$semkey=1234;
push(@stats, 'mode', 'uid', 'gid', 'cuid', 'cgid',
	     'nsems', 'otime', 'ctime');
print "Stats:\n" .  join (', ',@stats) . "\n" if ($debug);

use IPC::SysV qw(IPC_PRIVATE S_IRWXU IPC_CREAT);
use IPC::Semaphore;
use Class::Struct;

$sem = new IPC::Semaphore($semkey, 0, S_IRWXU );
if (not ref($sem) ) {
  print "semaphore for key $semkey, is not defined in the kernal.\n";
  exit 1;
}

1;
