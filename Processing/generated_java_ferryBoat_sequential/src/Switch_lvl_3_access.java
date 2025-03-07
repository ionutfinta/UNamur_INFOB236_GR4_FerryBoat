public class Switch_lvl_3_access{
	/*@ spec_public */ private fifthRef machine; // reference to the machine 

	/*@ public normal_behavior
		requires true;
		assignable \everything;
		ensures this.machine == m; */
	public Switch_lvl_3_access(fifthRef m) {
		this.machine = m;
	}

	/*@ public normal_behavior
		requires true;
 		assignable \nothing;
		ensures \result <==> (BOOL.instance.has(boolean) && !boolean.equals(machine.get_lvl_3_access()) && machine.get_lift_level().equals(new Integer(3)) && ((boolean.equals(true)) ==> (machine.get_Sensor_state().apply(new Integer(3)).equals(machine.Detecting)))); */
	public /*@ pure */ boolean guard_Switch_lvl_3_access( Boolean b) {
		return (BOOL.instance.has(b) //type check grd1
				&& !b.equals(machine.get_lvl_3_access()) //grd1, value is changing
				
				&& machine.get_lift_level().equals(new Integer(3)) //grd2, lift at 3
				&& BOOL.implication(b.equals(true),machine.get_Sensor_state().apply(new Integer(3)).equals(machine.Detecting))); //grd4_5, detected
	}

	/*@ public normal_behavior
		requires guard_Switch_lvl_3_access(boolean);
		assignable machine.lvl_3_access;
		ensures guard_Switch_lvl_3_access(boolean) &&  machine.get_lvl_3_access() == \old(boolean); 
	 also
		requires !guard_Switch_lvl_3_access(boolean);
		assignable \nothing;
		ensures true; */
	public void run_Switch_lvl_3_access( Boolean b){
		if(guard_Switch_lvl_3_access(b)) {
			Boolean lvl_3_access_tmp = machine.get_lvl_3_access();

			machine.set_lvl_3_access(b);

			System.out.println("Switch_lvl_3_access executed boolean: " + b + " ");
		}
	}

}
