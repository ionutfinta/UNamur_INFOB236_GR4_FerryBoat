package FerryBoat_multi_threaded; 

import eventb_prelude.*;
import Util.Utilities;

public class Switch_lift_access extends Thread{
	/*@ spec_public */ private fifthRef machine; // reference to the machine 

	/*@ public normal_behavior
		requires true;
		assignable \everything;
		ensures this.machine == m; */
	public Switch_lift_access(fifthRef m) {
		this.machine = m;
	}

	/*@ public normal_behavior
		requires true;
 		assignable \nothing;
		ensures \result <==> (machine.get_lift_level().equals(new Integer(1)) && BOOL.instance.has(boolean) && !boolean.equals(machine.get_lift_access()) && ((boolean.equals(true)) ==> (machine.get_Sensor_state().apply(new Integer(1)).equals(machine.Detecting)))); */
	public /*@ pure */ boolean guard_Switch_lift_access( Boolean boolean) {
		return (machine.get_lift_level().equals(new Integer(1)) && BOOL.instance.has(boolean) && !boolean.equals(machine.get_lift_access()) && BOOL.implication(boolean.equals(true),machine.get_Sensor_state().apply(new Integer(1)).equals(machine.Detecting)));
	}

	/*@ public normal_behavior
		requires guard_Switch_lift_access(boolean);
		assignable machine.lift_access;
		ensures guard_Switch_lift_access(boolean) &&  machine.get_lift_access() == \old(boolean); 
	 also
		requires !guard_Switch_lift_access(boolean);
		assignable \nothing;
		ensures true; */
	public void run_Switch_lift_access( Boolean boolean){
		if(guard_Switch_lift_access(boolean)) {
			Boolean lift_access_tmp = machine.get_lift_access();

			machine.set_lift_access(boolean);

			System.out.println("Switch_lift_access executed boolean: " + boolean + " ");
		}
	}

	public void run() {
		while(true) {
			Boolean boolean = Utilities.someVal(new BSet<Boolean>((true,false)));
			machine.lock.lock(); // start of critical section
			run_Switch_lift_access(boolean);
			machine.lock.unlock(); // end of critical section
		}
	}
}
