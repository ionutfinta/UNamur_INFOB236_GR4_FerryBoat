package ferryBoat_sequential; 

import eventb_prelude.*;
import Util.Utilities;

public class Switch_lift_in{
	/*@ spec_public */ private fifthRef machine; // reference to the machine 

	/*@ public normal_behavior
		requires true;
		assignable \everything;
		ensures this.machine == m; */
	public Switch_lift_in(fifthRef m) {
		this.machine = m;
	}

	/*@ public normal_behavior
		requires true;
 		assignable \nothing;
		ensures \result <==> (machine.get_lift_level().equals(new Integer(1)) && !boolean.equals(machine.get_lift_in()) && BOOL.instance.has(boolean) && ((boolean.equals(true)) ==> (machine.get_Sensor_state().apply(new Integer(1)).equals(machine.Detecting)))); */
	public /*@ pure */ boolean guard_Switch_lift_in( Boolean b) {
		return (machine.get_lift_level().equals(new Integer(1)) //grd1
				&& !b.equals(machine.get_lift_in()) //grd2
				
				&& BOOL.instance.has(b) && BOOL.implication(b.equals(true),machine.get_Sensor_state().apply(new Integer(1)).equals(machine.Detecting))); //grd3_5
	}

	/*@ public normal_behavior
		requires guard_Switch_lift_in(boolean);
		assignable machine.lift_in;
		ensures guard_Switch_lift_in(boolean) &&  machine.get_lift_in() == \old(boolean); 
	 also
		requires !guard_Switch_lift_in(boolean);
		assignable \nothing;
		ensures true; */
	public void run_Switch_lift_in( Boolean b){
		if(guard_Switch_lift_in(b)) {
			Boolean lift_in_tmp = machine.get_lift_in();

			machine.set_lift_in(b);

			System.out.println("Switch_lift_in executed boolean: " + b + " ");
		}
	}

}
