package FerryBoat_multi_threaded; 

import eventb_prelude.*;
import Util.Utilities;

public class Switch_lvl_2_access extends Thread{
	/*@ spec_public */ private fifthRef machine; // reference to the machine 

	/*@ public normal_behavior
		requires true;
		assignable \everything;
		ensures this.machine == m; */
	public Switch_lvl_2_access(fifthRef m) {
		this.machine = m;
	}

	/*@ public normal_behavior
		requires true;
 		assignable \nothing;
		ensures \result <==> (BOOL.instance.has(boolean) && !boolean.equals(machine.get_lvl_2_access()) && machine.get_lift_level().equals(new Integer(2)) && ((boolean.equals(true)) ==> (machine.get_Sensor_state().apply(new Integer(2)).equals(machine.Detecting)))); */
	public /*@ pure */ boolean guard_Switch_lvl_2_access( Boolean boolean) {
		return (BOOL.instance.has(boolean) && !boolean.equals(machine.get_lvl_2_access()) && machine.get_lift_level().equals(new Integer(2)) && BOOL.implication(boolean.equals(true),machine.get_Sensor_state().apply(new Integer(2)).equals(machine.Detecting)));
	}

	/*@ public normal_behavior
		requires guard_Switch_lvl_2_access(boolean);
		assignable machine.lvl_2_access;
		ensures guard_Switch_lvl_2_access(boolean) &&  machine.get_lvl_2_access() == \old(boolean); 
	 also
		requires !guard_Switch_lvl_2_access(boolean);
		assignable \nothing;
		ensures true; */
	public void run_Switch_lvl_2_access( Boolean boolean){
		if(guard_Switch_lvl_2_access(boolean)) {
			Boolean lvl_2_access_tmp = machine.get_lvl_2_access();

			machine.set_lvl_2_access(boolean);

			System.out.println("Switch_lvl_2_access executed boolean: " + boolean + " ");
		}
	}

	public void run() {
		while(true) {
			Boolean boolean = Utilities.someVal(new BSet<Boolean>((true,false)));
			machine.lock.lock(); // start of critical section
			run_Switch_lvl_2_access(boolean);
			machine.lock.unlock(); // end of critical section
		}
	}
}
