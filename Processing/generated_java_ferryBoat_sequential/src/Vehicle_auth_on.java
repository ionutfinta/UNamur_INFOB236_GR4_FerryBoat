public class Vehicle_auth_on{
	/*@ spec_public */ private fifthRef machine; // reference to the machine 

	/*@ public normal_behavior
		requires true;
		assignable \everything;
		ensures this.machine == m; */
	public Vehicle_auth_on(fifthRef m) {
		this.machine = m;
	}

	/*@ public normal_behavior
		requires true;
 		assignable \nothing;
		ensures \result <==> (machine.VEHICLE_TYPES.has(vehicle_type) && machine.get_reservations().domain().has(vehicle_id) && new Integer(new JMLObjectSet {Integer fInteger v | (exists Integer e; (machine.floors.has(f) && v.equals(vehicle_type)); e.equals(new Pair<Integer,Integer>(f,v)))}).has(machine.get_reservations().apply(vehicle_id)) && machine.get_lift_level().equals(new Integer(1)) && !machine.get_auth_on_ids().has(vehicle_id) && BOOL.instance.has(is_left) && ((is_left.equals(true)) ==> (machine.get_queue1().equals(true))) && ((is_left.equals(false)) ==> (machine.get_queue2().equals(true))) && !machine.get_boarded_ids().has(vehicle_id)); */
	public /*@ pure */ boolean guard_Vehicle_auth_on( Integer vehicle_id, Integer vehicle_type, Boolean is_left) {
		return (machine.VEHICLE_TYPES.has(vehicle_type) && //grd1_2
				machine.get_reservations().domain().has(vehicle_id) && //grd2_2 
				// La grd3_2 est une erreur de conception de toutes façons, on peut la laisser tomber:
				/*new Integer(new JMLObjectSet {Integer fInteger v | (exists Integer e; (machine.floors.has(f) && 
						v.equals(vehicle_type)); e.equals(new Pair<Integer,Integer>(f,v)))}).has(machine.get_reservations().apply(vehicle_id)) &&*/ 
				machine.get_lift_level().equals(new Integer(1)) && //grd4_2 
				!machine.get_auth_on_ids().has(vehicle_id) && //grd5_2
				BOOL.instance.has(is_left) && //grd1_3
				BOOL.implication(is_left.equals(true),machine.get_queue1().equals(true)) && //grd2_3 
				BOOL.implication(is_left.equals(false),machine.get_queue2().equals(true)) &&  //grd3_3
				!machine.get_boarded_ids().has(vehicle_id)); //grd4_3
	}

	/*@ public normal_behavior
		requires guard_Vehicle_auth_on(vehicle_id,vehicle_type,is_left);
		assignable machine.auth_on_ids, machine.id_is_left, machine.queue1, machine.queue2;
		ensures guard_Vehicle_auth_on(vehicle_id,vehicle_type,is_left) &&  machine.get_auth_on_ids().equals(\old((machine.get_auth_on_ids().union(new BSet<Integer>(vehicle_id))))) &&  machine.get_id_is_left().equals(\old((machine.get_id_is_left().override(new BRelation<Integer,Boolean>(new Pair<Integer,Boolean>(vehicle_id,is_left)))))) &&  machine.get_queue1() == \old((is_left.equals(false) && machine.get_queue1().equals(true))) &&  machine.get_queue2() == \old((is_left.equals(true) && machine.get_queue2().equals(true))); 
	 also
		requires !guard_Vehicle_auth_on(vehicle_id,vehicle_type,is_left);
		assignable \nothing;
		ensures true; */
	public void run_Vehicle_auth_on( Integer vehicle_id, Integer vehicle_type, Boolean is_left){
		if(guard_Vehicle_auth_on(vehicle_id,vehicle_type,is_left)) {
			BSet<Integer> auth_on_ids_tmp = machine.get_auth_on_ids();
			BRelation<Integer,Boolean> id_is_left_tmp = machine.get_id_is_left();
			Boolean queue1_tmp = machine.get_queue1();
			Boolean queue2_tmp = machine.get_queue2();

			machine.set_auth_on_ids((auth_on_ids_tmp.union(new BSet<Integer>(vehicle_id))));
			machine.set_id_is_left((id_is_left_tmp.override(new BRelation<Integer,Boolean>(new Pair<Integer,Boolean>(vehicle_id,is_left)))));
			machine.set_queue1((is_left.equals(false) && queue1_tmp.equals(true)));
			machine.set_queue2((is_left.equals(true) && queue2_tmp.equals(true)));

			System.out.println("Vehicle_auth_on executed vehicle_id: " + vehicle_id + " vehicle_type: " + vehicle_type + " is_left: " + is_left + " ");
		}
	}

}
