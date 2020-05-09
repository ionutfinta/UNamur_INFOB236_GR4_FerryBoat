package ferryBoat_sequential; 

import eventb_prelude.*;
import Util.Utilities;

public class Switch_lvl_1_access{
	/*@ spec_public */ private fifthRef machine; // reference to the machine 

	/*@ public normal_behavior
		requires true;
		assignable \everything;
		ensures this.machine == m; */
	public Switch_lvl_1_access(fifthRef m) {
		this.machine = m;
	}

	/*@ public normal_behavior
		requires true;
 		assignable \nothing;
		ensures \result <==> (BOOL.instance.has(boolean) && !boolean.equals(machine.get_lvl_1_access()) && machine.get_lift_level().equals(new Integer(1)) && ((boolean.equals(true)) ==> (machine.get_Sensor_state().apply(new Integer(1)).equals(machine.Detecting)))); */
	public /*@ pure */ boolean guard_Switch_lvl_1_access( Boolean b) {
		return (BOOL.instance.has(b) && !b.equals(machine.get_lvl_1_access()) && machine.get_lift_level().equals(new Integer(1)) && BOOL.implication(b.equals(true),machine.get_Sensor_state().apply(new Integer(1)).equals(machine.Detecting)));
	}

	/*@ public normal_behavior
		requires guard_Switch_lvl_1_access(boolean);
		assignable machine.lvl_1_access;
		ensures guard_Switch_lvl_1_access(boolean) &&  machine.get_lvl_1_access() == \old(boolean); 
	 also
		requires !guard_Switch_lvl_1_access(boolean);
		assignable \nothing;
		ensures true; */
	public void run_Switch_lvl_1_access( Boolean b){
		if(guard_Switch_lvl_1_access(b)) {
			Boolean lvl_1_access_tmp = machine.get_lvl_1_access();

			machine.set_lvl_1_access(b);

			System.out.println("Switch_lvl_1_access executed boolean: " + b + " ");
		}
	}

}
