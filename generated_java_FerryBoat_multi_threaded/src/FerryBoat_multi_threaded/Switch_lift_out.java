package FerryBoat_multi_threaded; 

import eventb_prelude.*;
import Util.Utilities;

public class Switch_lift_out extends Thread{
	/*@ spec_public */ private fifthRef machine; // reference to the machine 

	/*@ public normal_behavior
		requires true;
		assignable \everything;
		ensures this.machine == m; */
	public Switch_lift_out(fifthRef m) {
		this.machine = m;
	}

	/*@ public normal_behavior
		requires true;
 		assignable \nothing;
		ensures \result <==> (!boolean.equals(machine.get_lift_out()) && BOOL.instance.has(boolean) && ((boolean.equals(true)) ==> (machine.get_Sensor_state().apply(machine.get_lift_level()).equals(machine.Detecting)))); */
	public /*@ pure */ boolean guard_Switch_lift_out( Boolean boolean) {
		return (!boolean.equals(machine.get_lift_out()) && BOOL.instance.has(boolean) && BOOL.implication(boolean.equals(true),machine.get_Sensor_state().apply(machine.get_lift_level()).equals(machine.Detecting)));
	}

	/*@ public normal_behavior
		requires guard_Switch_lift_out(boolean);
		assignable machine.lift_out;
		ensures guard_Switch_lift_out(boolean) &&  machine.get_lift_out() == \old(boolean); 
	 also
		requires !guard_Switch_lift_out(boolean);
		assignable \nothing;
		ensures true; */
	public void run_Switch_lift_out( Boolean boolean){
		if(guard_Switch_lift_out(boolean)) {
			Boolean lift_out_tmp = machine.get_lift_out();

			machine.set_lift_out(boolean);

			System.out.println("Switch_lift_out executed boolean: " + boolean + " ");
		}
	}

	public void run() {
		while(true) {
			Boolean boolean = Utilities.someVal(new BSet<Boolean>((true,false)));
			machine.lock.lock(); // start of critical section
			run_Switch_lift_out(boolean);
			machine.lock.unlock(); // end of critical section
		}
	}
}
