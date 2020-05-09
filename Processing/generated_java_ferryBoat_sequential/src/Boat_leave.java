public class Boat_leave{
	/*@ spec_public */ private fifthRef machine; // reference to the machine 

	/*@ public normal_behavior
		requires true;
		assignable \everything;
		ensures this.machine == m; */
	public Boat_leave(fifthRef m) {
		this.machine = m;
	}

	/*@ public normal_behavior
		requires true;
 		assignable \nothing;
		ensures \result <==> ((new Integer(0)).compareTo(machine.get_max_busy_slots()) < 0 && machine.get_auth_on_ids().equals(BSet.EMPTY)); */
	public /*@ pure */ boolean guard_Boat_leave() {
		return ((new Integer(0)).compareTo(machine.get_max_busy_slots()) < 0 
				&& machine.get_auth_on_ids().equals(BSet.EMPTY));
	}

	/*@ public normal_behavior
		requires guard_Boat_leave();
		assignable machine.busy_slots, machine.max_busy_slots, machine.bs_p, machine.max_bs_p, machine.reservations, machine.reserved_spaces, machine.boarded_ids, machine.lift_vehicles, machine.id_is_left;
		ensures guard_Boat_leave() &&  machine.get_busy_slots() == \old(0) &&  machine.get_max_busy_slots() == \old(0) &&  machine.get_bs_p().equals(\old(new no_type(new JMLObjectSet {Integer f | (\exists no_type e; (machine.floors.has(null)); e.equals(new Pair<Integer,ERROR>(null,0)))}))) &&  machine.get_max_bs_p().equals(\old(new no_type(new JMLObjectSet {Integer f | (\exists no_type e; (machine.floors.has(null)); e.equals(new Pair<Integer,ERROR>(null,0)))}))) &&  machine.get_reservations().equals(\old(BRelation.EMPTY)) &&  machine.get_reserved_spaces().equals(\old(new no_type(new JMLObjectSet {Integer f | (\exists no_type e; (machine.floors.has(null)); e.equals(new Pair<Integer,ERROR>(null,0)))}))) &&  machine.get_boarded_ids().equals(\old(BSet.EMPTY)) &&  machine.get_lift_vehicles().equals(\old(BRelation.EMPTY)) &&  machine.get_id_is_left().equals(\old(BRelation.EMPTY)); 
	 also
		requires !guard_Boat_leave();
		assignable \nothing;
		ensures true; */
	public void run_Boat_leave(){
		if(guard_Boat_leave()) {
			Integer busy_slots_tmp = machine.get_busy_slots();
			Integer max_busy_slots_tmp = machine.get_max_busy_slots();
			BRelation<Integer,Integer> bs_p_tmp = machine.get_bs_p();
			BRelation<Integer,Integer> max_bs_p_tmp = machine.get_max_bs_p();
			BRelation<Integer,Pair<Integer,Integer>> reservations_tmp = machine.get_reservations();
			BRelation<Integer,Integer> reserved_spaces_tmp = machine.get_reserved_spaces();
			BSet<Integer> boarded_ids_tmp = machine.get_boarded_ids();
			BRelation<Pair<Integer,Integer>,Integer> lift_vehicles_tmp = machine.get_lift_vehicles();
			BRelation<Integer,Boolean> id_is_left_tmp = machine.get_id_is_left();

			machine.set_busy_slots(0); //act 1
			machine.set_max_busy_slots(0); //act2
			BRelation<Integer, Integer> eachfloor0 = new BRelation<Integer, Integer>();
			for(int  i = 0; i <= machine.floors.max(); i++) {
				eachfloor0.insert(i, 0);
			}
			machine.set_bs_p(eachfloor0); //act3_1
			machine.set_max_bs_p(eachfloor0); //arc4_1
			machine.set_reservations(BRelation.EMPTY); //act5_2
			machine.set_reserved_spaces(eachfloor0); //act7_2
			machine.set_boarded_ids(BSet.EMPTY); //act3_3
			machine.set_lift_vehicles(BRelation.EMPTY); //act4_3
			machine.set_id_is_left(BRelation.EMPTY); //act5_3

			System.out.println("Boat_leave executed ");
		}
	}

}
