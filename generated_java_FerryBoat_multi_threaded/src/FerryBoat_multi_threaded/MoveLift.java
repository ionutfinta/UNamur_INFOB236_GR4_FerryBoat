package FerryBoat_multi_threaded; 

import eventb_prelude.*;
import Util.Utilities;

public class MoveLift extends Thread{
	/*@ spec_public */ private fifthRef machine; // reference to the machine 

	/*@ public normal_behavior
		requires true;
		assignable \everything;
		ensures this.machine == m; */
	public MoveLift(fifthRef m) {
		this.machine = m;
	}

	/*@ public normal_behavior
		requires true;
 		assignable \nothing;
		ensures \result <==> (machine.floors.has(selected_level) && machine.get_lift_access().equals(false) && machine.get_lift_in().equals(false) && machine.get_lift_out().equals(false) && machine.get_lvl_1_access().equals(false) && machine.get_lvl_2_access().equals(false) && machine.get_lvl_3_access().equals(false)); */
	public /*@ pure */ boolean guard_MoveLift( Integer selected_level) {
		return (machine.floors.has(selected_level) && machine.get_lift_access().equals(false) && machine.get_lift_in().equals(false) && machine.get_lift_out().equals(false) && machine.get_lvl_1_access().equals(false) && machine.get_lvl_2_access().equals(false) && machine.get_lvl_3_access().equals(false));
	}

	/*@ public normal_behavior
		requires guard_MoveLift(selected_level);
		assignable machine.lift_level;
		ensures guard_MoveLift(selected_level) &&  machine.get_lift_level() == \old(selected_level); 
	 also
		requires !guard_MoveLift(selected_level);
		assignable \nothing;
		ensures true; */
	public void run_MoveLift( Integer selected_level){
		if(guard_MoveLift(selected_level)) {
			Integer lift_level_tmp = machine.get_lift_level();

			machine.set_lift_level(selected_level);

			System.out.println("MoveLift executed selected_level: " + selected_level + " ");
		}
	}

	public void run() {
		while(true) {
			Integer selected_level = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));
			machine.lock.lock(); // start of critical section
			run_MoveLift(selected_level);
			machine.lock.unlock(); // end of critical section
		}
	}
}
