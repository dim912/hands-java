
//if some one else is alrady doing some operation --> stack lock error is thrown

resource "time_sleep" "wait_300_seconds" {
  create_duration = "300s"
}

//locally tf creates a terrafrom.state.lock file ( which contains a lock ID , userID , creation, path etc)
//once the operation is done ==> Then tf delete the lock file

//lock happen for all operatons which can write on the state
//if state locking fails, then tf does not continue
//not all backend support state locking



//FORCE UNLOCKING STATE

//tf force-unlock