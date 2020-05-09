public class Sensor_stops_detecting{
	/*@ spec_public */ private fifthRef machine; // reference to the machine 

	/*@ public normal_behavior
		requires true;
		assignable \everything;
		ensures this.machine == m; */
	public Sensor_stops_detecting(fifthRef m) {
		this.machine = m;
	}

	/*@ public normal_behavior
		requires true;
 		assignable \nothing;
		ensures \result <==> (new Enumerated(new Integer(1),new Integer(3)).has(sensor) && !machine.get_Sensor_state().apply(sensor).equals(machine.Not_Detecting) && machine.get_lift_in().equals(false) && machine.get_lift_out().equals(false) && ((sensor.equals(new Integer(1))) ==> (machine.get_lift_access().equals(false) && machine.get_lvl_1_access().equals(false))) && ((sensor.equals(new Integer(2))) ==> (machine.get_lvl_2_access().equals(false))) && ((sensor.equals(new Integer(3))) ==> (machine.get_lvl_3_access().equals(false)))); */
	public /*@ pure */ boolean guard_Sensor_stops_detecting( Integer sensor) {
		return (new Enumerated(new Integer(1),new Integer(3)).has(sensor) //grd2_5 argument in 1..3
				&& !machine.get_Sensor_state().apply(sensor).equals(machine.Not_Detecting) //grd3_5
				&& machine.get_lift_in().equals(false) //grd4_5
				&& machine.get_lift_out().equals(false) //grd5_5
				&& BOOL.implication(sensor.equals(new Integer(1)),machine.get_lift_access().equals(false) && machine.get_lvl_1_access().equals(false)) //grd6
				&& BOOL.implication(sensor.equals(new Integer(2)),machine.get_lvl_2_access().equals(false)) //grd7
				&& BOOL.implication(sensor.equals(new Integer(3)),machine.get_lvl_3_access().equals(false)));//grd8
	}

	/*@ public normal_behavior
		requires guard_Sensor_stops_detecting(sensor);
		assignable machine.Sensor_state;
		ensures guard_Sensor_stops_detecting(sensor) &&  machine.get_Sensor_state().equals(\old((machine.get_Sensor_state().override(new BRelation<Integer,Integer>(new Pair<Integer,Integer>(sensor,machine.Not_Detecting)))))); 
	 also
		requires !guard_Sensor_stops_detecting(sensor);
		assignable \nothing;
		ensures true; */
	public void run_Sensor_stops_detecting( Integer sensor){
		if(guard_Sensor_stops_detecting(sensor)) {
			BRelation<Integer,Integer> Sensor_state_tmp = machine.get_Sensor_state();

			machine.set_Sensor_state((Sensor_state_tmp.override(new BRelation<Integer,Integer>(new Pair<Integer,Integer>(sensor,machine.Not_Detecting)))));

			System.out.println("Sensor_stops_detecting executed sensor: " + sensor + " ");
		}
	}

}
