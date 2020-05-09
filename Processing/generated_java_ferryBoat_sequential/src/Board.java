 
public class Board{
	/*@ spec_public */ private fifthRef machine; // reference to the machine 

	/*@ public normal_behavior
		requires true;
		assignable \everything;
		ensures this.machine == m; */
	public Board(fifthRef m) {
		this.machine = m;
	}

	/*@ public normal_behavior
		requires true;
 		assignable \nothing;
		ensures \result <==> (machine.VEHICLE_TYPES.has(vehicle_type) && (new Integer(machine.get_busy_slots() + machine.vehicle_slot.apply(vehicle_type))).compareTo(machine.get_max_busy_slots()) <= 0 && (machine.vehicle_slot.apply(vehicle_type)).compareTo(machine.get_bs_m()) <= 0 && (new Integer(machine.vehicle_slot.apply(vehicle_type) + machine.get_bs_p().apply(machine.get_lift_level()))).compareTo(machine.get_max_bs_p().apply(machine.get_lift_level())) <= 0 && machine.get_reservations().domain().has(vehicle_id) && machine.get_reservations().apply(vehicle_id).equals(new Pair<Integer,Integer>(machine.get_lift_level(),vehicle_type)) && machine.get_lift_vehicles().range().has(vehicle_id) && machine.get_lift_out().equals(true) && ((machine.get_lift_level().equals(new Integer(1))) ==> (machine.get_lvl_1_access().equals(true))) && ((machine.get_lift_level().equals(new Integer(2))) ==> (machine.get_lvl_2_access().equals(true))) && ((machine.get_lift_level().equals(new Integer(3))) ==> (machine.get_lvl_3_access().equals(true))) && machine.get_Sensor_state().apply(machine.get_lift_level()).equals(machine.Detecting)); */
	public /*@ pure */ boolean guard_Board( Integer vehicle_id, Integer vehicle_type) {
		return (machine.VEHICLE_TYPES.has(vehicle_type) //grd2_2
				&& (new Integer(machine.get_busy_slots() + machine.vehicle_slot.apply(vehicle_type))).compareTo(machine.get_max_busy_slots()) <= 0 //grd3_2
				&& (machine.vehicle_slot.apply(vehicle_type)).compareTo(machine.get_bs_m()) <= 0 
				&& (new Integer(machine.vehicle_slot.apply(vehicle_type) + machine.get_bs_p().apply(machine.get_lift_level()))).compareTo(machine.get_max_bs_p().apply(machine.get_lift_level())) <= 0 
				&& machine.get_reservations().domain().has(vehicle_id) 
				&& machine.get_reservations().apply(vehicle_id).equals(new Pair<Integer,Integer>(machine.get_lift_level(),vehicle_type)) 
				&& machine.get_lift_vehicles().range().has(vehicle_id) 
				&& machine.get_lift_out().equals(true) 
				&& BOOL.implication(machine.get_lift_level().equals(new Integer(1)),machine.get_lvl_1_access().equals(true)) 
				&& BOOL.implication(machine.get_lift_level().equals(new Integer(2)),machine.get_lvl_2_access().equals(true)) 
				&& BOOL.implication(machine.get_lift_level().equals(new Integer(3)),machine.get_lvl_3_access().equals(true)) 
				&& machine.get_Sensor_state().apply(machine.get_lift_level()).equals(machine.Detecting));
	}

	/*@ public normal_behavior
		requires guard_Board(vehicle_id,vehicle_type);
		assignable machine.busy_slots, machine.bs_p, machine.bs_m, machine.in_lift_ids, machine.lift_vehicles;
		ensures guard_Board(vehicle_id,vehicle_type) &&  machine.get_busy_slots() == \old(new Integer(machine.get_busy_slots() + machine.vehicle_slot.apply(vehicle_type))) &&  machine.get_bs_p().equals(\old((machine.get_bs_p().override(new BRelation<Integer,Integer>(new Pair<Integer,Integer>(machine.get_lift_level(),new Integer(machine.get_bs_p().apply(machine.get_lift_level()) + machine.vehicle_slot.apply(vehicle_type)))))))) &&  machine.get_bs_m() == \old(new Integer(machine.get_bs_m() - machine.vehicle_slot.apply(vehicle_type))) &&  machine.get_in_lift_ids().equals(\old(machine.get_in_lift_ids().difference(new BSet<Integer>(vehicle_id)))) &&  machine.get_lift_vehicles().equals(\old(machine.get_lift_vehicles().difference(new no_type(new JMLObjectSet {Pair<Integer,Integer> x | (\exists no_type e; (BRelation.cross(new Enumerated(1,2),new Enumerated(1,3)).has(null) && machine.get_lift_vehicles().apply(null).equals(vehicle_id)); e.equals(new Pair<Integer,ERROR>(null,vehicle_id)))})))); 
	 also
		requires !guard_Board(vehicle_id,vehicle_type);
		assignable \nothing;
		ensures true; */
	public void run_Board( Integer vehicle_id, Integer vehicle_type){
		if(guard_Board(vehicle_id,vehicle_type)) {
			Integer busy_slots_tmp = machine.get_busy_slots();
			BRelation<Integer,Integer> bs_p_tmp = machine.get_bs_p();
			Integer bs_m_tmp = machine.get_bs_m();
			BSet<Integer> in_lift_ids_tmp = machine.get_in_lift_ids();
			BRelation<Pair<Integer,Integer>,Integer> lift_vehicles_tmp = machine.get_lift_vehicles();

			machine.set_busy_slots(new Integer(busy_slots_tmp + machine.vehicle_slot.apply(vehicle_type)));
			machine.set_bs_p((bs_p_tmp.override(new BRelation<Integer,Integer>(new Pair<Integer,Integer>(machine.get_lift_level(),new Integer(bs_p_tmp.apply(machine.get_lift_level()) + machine.vehicle_slot.apply(vehicle_type)))))));
			machine.set_bs_m(new Integer(bs_m_tmp - machine.vehicle_slot.apply(vehicle_type)));
			machine.set_in_lift_ids(in_lift_ids_tmp.difference(new BSet<Integer>(vehicle_id)));
			
			// Rewritten:
			for(Pair<Integer, Integer> p : lift_vehicles_tmp.inverseElementImage(vehicle_id)) {
				lift_vehicles_tmp.remove(
						p,
						vehicle_id);
			}
			
			machine.set_lift_vehicles(lift_vehicles_tmp);
					
					/* Generated automatically but not working:
					 * .difference(
							new no_type(
									new JMLObjectSet {
										Pair<Integer,Integer> x | (
												\exists no_type e; (
														BRelation.cross(
																new Enumerated(1,2),
																new Enumerated(1,3)).has(null)
														&&
														lift_vehicles_tmp.apply(null).equals(vehicle_id));
												e.equals(new Pair<Integer,ERROR>(null,vehicle_id)))})));*/

			System.out.println("Board executed vehicle_id: " + vehicle_id + " vehicle_type: " + vehicle_type + " ");
		}
	}

}
