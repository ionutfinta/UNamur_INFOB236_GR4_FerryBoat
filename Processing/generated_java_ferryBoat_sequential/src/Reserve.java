public class Reserve{
	/*@ spec_public */ private fifthRef machine; // reference to the machine 

	/*@ public normal_behavior
		requires true;
		assignable \everything;
		ensures this.machine == m; */
	public Reserve(fifthRef m) {
		this.machine = m;
	}
	
	private boolean checkPrioriteCamionsP1(int floor, int vehicle_type){
		if(vehicle_type == machine.voiture && floor < machine.floors.max()) {
			for(int a = machine.floors.max(); a > floor; a--) {
				if(machine.get_max_bs_p().apply(a) == null)
					return false;
				if(machine.get_reserved_spaces().apply(a) == null ||
						machine.get_reserved_spaces().apply(a)
						.compareTo(machine.get_max_bs_p().apply(a)) > 0) {
					return false;
				}
			}
		}else if(vehicle_type != machine.voiture && floor > 1) {
			for(int a = 1; a < floor; a++) {
				/*if(true)
						throw new Exception("Hello world !µ" + machine.get_reserved_spaces().apply(a).compareTo(machine.get_max_bs_p().apply(a)));*/
				if(machine.get_reserved_spaces().apply(a) == null || 
						machine.get_reserved_spaces().apply(a).compareTo(machine.get_max_bs_p().apply(a)) >= machine.vehicle_slot.apply(vehicle_type))
					return false;
			}
		}
		return true;
	}

	/*@ public normal_behavior
		requires true;
 		assignable \nothing;
		ensures \result <==> (machine.VEHICLE_TYPES.has(vehicle_type) && ((vehicle_type.equals(machine.voiture)) ==> ( (\forall Integer f;((machine.floors.has(f) && (f).compareTo(floor) > 0) ==> ((new Integer(machine.get_reserved_spaces().apply(f) + machine.vehicle_slot.apply(vehicle_type))).compareTo(machine.get_max_bs_p().apply(f)) > 0))))) && machine.floors.has(floor) && ((!vehicle_type.equals(machine.voiture)) ==> ( (\forall Integer f;((machine.floors.has(f) && (f).compareTo(floor) < 0) ==> ((new Integer(machine.get_reserved_spaces().apply(f) + machine.vehicle_slot.apply(vehicle_type))).compareTo(machine.get_max_bs_p().apply(f)) > 0))))) && (new Integer(machine.get_reserved_spaces().apply(floor) + machine.vehicle_slot.apply(vehicle_type))).compareTo(machine.get_max_bs_p().apply(floor)) <= 0); */
	public /*@ pure */ boolean guard_Reserve( Integer floor, Integer vehicle_type) {
		return (machine.VEHICLE_TYPES.has(vehicle_type)
				&& machine.floors.has(floor)
				&& machine.get_max_bs_p() != null
				&& (machine.get_reserved_spaces().apply(floor) == null || (new Integer(machine.get_reserved_spaces().apply(floor) 
						+ machine.vehicle_slot.apply(vehicle_type)))
				.compareTo(machine.get_max_bs_p()
						.apply(floor)) <= 0)
				// grd4_2 && grd2_2 a été générée en && true
				// On en fait une fonction à part:
				&& checkPrioriteCamionsP1(floor, vehicle_type)); //grd5_2
	}

	/*@ public normal_behavior
		requires guard_Reserve(floor,vehicle_type);
		assignable machine.reservations, machine.reserved_spaces;
		ensures guard_Reserve(floor,vehicle_type) &&  machine.get_reservations().equals(\old((machine.get_reservations().override(new BRelation<Integer,Pair<Integer,Integer>>(new Pair<ERROR,Pair<Integer,Integer>>(new Integer(new Integer(machine.get_reservations().size()) + 1),new Pair<Integer,Integer>(floor,vehicle_type))))))) &&  machine.get_reserved_spaces().equals(\old((machine.get_reserved_spaces().override(new BRelation<Integer,Integer>(new Pair<Integer,Integer>(floor,new Integer(machine.get_reserved_spaces().apply(floor) + machine.vehicle_slot.apply(vehicle_type)))))))); 
	 also
		requires !guard_Reserve(floor,vehicle_type);
		assignable \nothing;
		ensures true; */
	public void run_Reserve( Integer floor, Integer vehicle_type){
		if(guard_Reserve(floor,vehicle_type)) {
			BRelation<Integer,Pair<Integer,Integer>> reservations_tmp = machine.get_reservations();
			BRelation<Integer,Integer> reserved_spaces_tmp = machine.get_reserved_spaces();
			int befSpace = 0;
			if(reserved_spaces_tmp.apply(floor) != null)
				befSpace = reserved_spaces_tmp.apply(floor);

			machine.set_reservations((reservations_tmp.override(new BRelation<Integer,Pair<Integer,Integer>>(new Pair<Integer,Pair<Integer,Integer>>(new Integer(new Integer(reservations_tmp.size()) + 1),new Pair<Integer,Integer>(floor,vehicle_type))))));
			machine.set_reserved_spaces((reserved_spaces_tmp.override(
					new BRelation<Integer,Integer>(
							new Pair<Integer,Integer>(
									floor,
									new Integer(
											befSpace + machine.vehicle_slot.apply(vehicle_type)))))));

			System.out.println("Reserve executed floor: " + floor + " vehicle_type: " + vehicle_type + " ");
		}
	}

}
