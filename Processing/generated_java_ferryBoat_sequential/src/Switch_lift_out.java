public class Switch_lift_out{
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
	public /*@ pure */ boolean guard_Switch_lift_out( Boolean b) {
		return (!b.equals(machine.get_lift_out()) //grd1, check change
				&& BOOL.instance.has(b)  //grd1, type
				&& BOOL.implication(b.equals(true),machine.get_Sensor_state().apply(machine.get_lift_level()).equals(machine.Detecting))); //grd5_5, lift detected if switching to true
	}

	/*@ public normal_behavior
		requires guard_Switch_lift_out(boolean);
		assignable machine.lift_out;
		ensures guard_Switch_lift_out(boolean) &&  machine.get_lift_out() == \old(boolean); 
	 also
		requires !guard_Switch_lift_out(boolean);
		assignable \nothing;
		ensures true; */
	public void run_Switch_lift_out( Boolean b){
		if(guard_Switch_lift_out(b)) {
			Boolean lift_out_tmp = machine.get_lift_out();

			machine.set_lift_out(b);

			System.out.println("Switch_lift_out executed boolean: " + b + " ");
		}
	}

}
