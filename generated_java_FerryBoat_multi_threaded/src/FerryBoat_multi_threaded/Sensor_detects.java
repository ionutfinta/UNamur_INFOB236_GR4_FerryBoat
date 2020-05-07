package FerryBoat_multi_threaded; 

import eventb_prelude.*;
import Util.Utilities;

public class Sensor_detects extends Thread{
	/*@ spec_public */ private fifthRef machine; // reference to the machine 

	/*@ public normal_behavior
		requires true;
		assignable \everything;
		ensures this.machine == m; */
	public Sensor_detects(fifthRef m) {
		this.machine = m;
	}

	/*@ public normal_behavior
		requires true;
 		assignable \nothing;
		ensures \result <==> (new Enumerated(new Integer(1),new Integer(3)).has(sensor) && !machine.get_Sensor_state().apply(sensor).equals(machine.Detecting) && machine.get_Sensor_state().apply(machine.get_lift_level()).equals(machine.Not_Detecting) && sensor.equals(machine.get_lift_level()) &&  (\forall Integer x;((new Enumerated(new Integer(1),new Integer(3)).has(x) && !x.equals(machine.get_lift_level())) ==> (!machine.get_Sensor_state().apply(x).equals(machine.Detecting))))); */
	public /*@ pure */ boolean guard_Sensor_detects( Integer sensor) {
		return (new Enumerated(new Integer(1),new Integer(3)).has(sensor) && !machine.get_Sensor_state().apply(sensor).equals(machine.Detecting) && machine.get_Sensor_state().apply(machine.get_lift_level()).equals(machine.Not_Detecting) && sensor.equals(machine.get_lift_level()) && true);
	}

	/*@ public normal_behavior
		requires guard_Sensor_detects(sensor);
		assignable machine.Sensor_state;
		ensures guard_Sensor_detects(sensor) &&  machine.get_Sensor_state().equals(\old((machine.get_Sensor_state().override(new BRelation<Integer,Integer>(new Pair<Integer,Integer>(sensor,machine.Detecting)))))); 
	 also
		requires !guard_Sensor_detects(sensor);
		assignable \nothing;
		ensures true; */
	public void run_Sensor_detects( Integer sensor){
		if(guard_Sensor_detects(sensor)) {
			BRelation<Integer,Integer> Sensor_state_tmp = machine.get_Sensor_state();

			machine.set_Sensor_state((Sensor_state_tmp.override(new BRelation<Integer,Integer>(new Pair<Integer,Integer>(sensor,machine.Detecting)))));

			System.out.println("Sensor_detects executed sensor: " + sensor + " ");
		}
	}

	public void run() {
		while(true) {
			Integer sensor = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));
			machine.lock.lock(); // start of critical section
			run_Sensor_detects(sensor);
			machine.lock.unlock(); // end of critical section
		}
	}
}
