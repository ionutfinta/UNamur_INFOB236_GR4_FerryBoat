package ferryBoat_sequential; 

import eventb_prelude.*;
import Util.Utilities;

public class Switch_lift_access{
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
	public /*@ pure */ boolean guard_Switch_lift_access( Boolean b) {
		return (machine.get_lift_level().equals(new Integer(1)) && BOOL.instance.has(b) && !b.equals(machine.get_lift_access()) && BOOL.implication(b.equals(true),machine.get_Sensor_state().apply(new Integer(1)).equals(machine.Detecting)));
	}

	/*@ public normal_behavior
		requires guard_Switch_lift_access(boolean);
		assignable machine.lift_access;
		ensures guard_Switch_lift_access(boolean) &&  machine.get_lift_access() == \old(boolean); 
	 also
		requires !guard_Switch_lift_access(boolean);
		assignable \nothing;
		ensures true; */
	public void run_Switch_lift_access( Boolean b){
		if(guard_Switch_lift_access(b)) {
			Boolean lift_access_tmp = machine.get_lift_access();

			machine.set_lift_access(b);

			System.out.println("Switch_lift_access executed boolean: " + b + " ");
		}
	}

}
