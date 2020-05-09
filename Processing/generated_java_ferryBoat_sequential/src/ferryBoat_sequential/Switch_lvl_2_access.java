package ferryBoat_sequential; 

import eventb_prelude.*;
import Util.Utilities;

public class Switch_lvl_2_access{
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
	public /*@ pure */ boolean guard_Switch_lvl_2_access( Boolean b) {
		return (BOOL.instance.has(b) //same as Switch_lvl_access_3, correct
				&& !b.equals(machine.get_lvl_2_access()) 
				
				&& machine.get_lift_level().equals(new Integer(2)) 
				&& BOOL.implication(b.equals(true),machine.get_Sensor_state().apply(new Integer(2)).equals(machine.Detecting)));
	}

	/*@ public normal_behavior
		requires guard_Switch_lvl_2_access(boolean);
		assignable machine.lvl_2_access;
		ensures guard_Switch_lvl_2_access(boolean) &&  machine.get_lvl_2_access() == \old(boolean); 
	 also
		requires !guard_Switch_lvl_2_access(boolean);
		assignable \nothing;
		ensures true; */
	public void run_Switch_lvl_2_access( Boolean b){
		if(guard_Switch_lvl_2_access(b)) {
			Boolean lvl_2_access_tmp = machine.get_lvl_2_access();

			machine.set_lvl_2_access(b);

			System.out.println("Switch_lvl_2_access executed boolean: " + b + " ");
		}
	}

}
