public class BoardLift{
	/*@ spec_public */ private fifthRef machine; // reference to the machine 

	/*@ public normal_behavior
		requires true;
		assignable \everything;
		ensures this.machine == m; */
	public BoardLift(fifthRef m) {
		this.machine = m;
	}
	
	// Donne le slot le plus profond disponible sur la plateforme du lift selon la file et les slots requis, 0 dans le cas échéant.
	private int getMinSlot(int queue, int needed_slots) {
		for(int i = machine.lift_depth; i >= 1; i--) {
			if(machine.get_lift_vehicles().domain().has(new Pair<Integer, Integer>(queue, i)))
				continue;
			return i;
		}
		return 0;
	}

	/*@ public normal_behavior
		requires true;
 		assignable \nothing;
		ensures \result <==> ((new Integer(machine.vehicle_slot.apply(vehicle_type) + machine.get_bs_m())).compareTo(machine.max_bs_m) <= 0 && machine.get_lift_level().equals(new Integer(1)) && machine.get_auth_on_ids().has(vehicle_id) && machine.VEHICLE_TYPES.has(vehicle_type) && new Integer(new JMLObjectSet {Integer fInteger v | (exists Integer e; (machine.floors.has(f) && v.equals(vehicle_type)); e.equals(new Pair<Integer,Integer>(f,v)))}).has(machine.get_reservations().apply(vehicle_id)) && new Enumerated(new Integer(1),machine.queues).has(position_q) && ((machine.get_id_is_left().apply(vehicle_id).equals(true)) ==> (position_q.equals(new Integer(1)))) && ((machine.get_id_is_left().apply(vehicle_id).equals(false)) ==> (position_q.equals(new Integer(2)))) && new Enumerated(new Integer(1),machine.lift_depth).has(position_s) && position_s.equals((new BSet<Integer>(new Integer(machine.lift_depth + new Integer(1))).union(new Integer(new JMLObjectSet {Integer x | (\exists Integer e; (new Enumerated(new Integer(1),new Integer(new Integer(4) - machine.vehicle_slot.apply(vehicle_type))).has(x) && (x).compareTo((new BSet<Integer>(new Integer(0)).union(new Integer(new JMLObjectSet {Integer y | (\exists Integer e; (new Enumerated(new Integer(1),machine.lift_depth).has(y) && machine.get_lift_vehicles().domain().has(new Pair<Integer,Integer>(position_q,y))); e.equals(y))}))).max()) > 0); e.equals(x))}))).min()) && machine.get_lift_access().equals(true) && machine.get_lift_in().equals(true)); */
	public /*@ pure */ boolean guard_BoardLift( Integer vehicle_id, Integer vehicle_type, Integer position_q, Integer position_s) {
		Integer max_bs_m = machine.max_bs_m;
		BRelation<Integer, Integer> vehicle_slot = machine.vehicle_slot;
		return (
				(new Integer(vehicle_slot.apply(vehicle_type) + machine.get_bs_m())).compareTo(max_bs_m) <= 0 
				&& machine.get_lift_level().equals(new Integer(1))
				&& machine.get_auth_on_ids().has(vehicle_id) 
				&& machine.VEHICLE_TYPES.has(vehicle_type) 
				&& machine.get_reservations().domain().has(vehicle_id) // La garde 2_2 a été mal conçue en Event-B 
				&& new Enumerated(new Integer(1),machine.queues).has(position_q)
				&& BOOL.implication(machine.get_id_is_left().apply(vehicle_id).equals(true),position_q.equals(new Integer(1))) 
				&& BOOL.implication(machine.get_id_is_left().apply(vehicle_id).equals(false),position_q.equals(new Integer(2))) 
				&& new Enumerated(new Integer(1),machine.lift_depth).has(position_s)
				&& position_s.equals(this.getMinSlot(position_q, machine.vehicle_slot.apply(vehicle_type)))
				//La guarde 4_3 n'a même pas été générée: && true 
				&& machine.get_lift_access().equals(true) 
				&& machine.get_lift_in().equals(true));
	}

	/*@ public normal_behavior
		requires guard_BoardLift(vehicle_id,vehicle_type,position_q,position_s);
		assignable machine.bs_m, machine.auth_on_ids, machine.in_lift_ids, machine.boarded_ids, machine.lift_vehicles;
		ensures guard_BoardLift(vehicle_id,vehicle_type,position_q,position_s) &&  machine.get_bs_m() == \old(new Integer(machine.vehicle_slot.apply(vehicle_type) + machine.get_bs_m())) &&  machine.get_auth_on_ids().equals(\old(machine.get_auth_on_ids().difference(new BSet<Integer>(vehicle_id)))) &&  machine.get_in_lift_ids().equals(\old((machine.get_in_lift_ids().union(new BSet<Integer>(vehicle_id))))) &&  machine.get_boarded_ids().equals(\old((new BSet<Integer>(vehicle_id).union(machine.get_boarded_ids())))) &&  machine.get_lift_vehicles().equals(\old((machine.get_lift_vehicles().union(new BRelation<Pair<Integer,Integer>,Integer>(new JMLObjectSet {Pair<Integer,Integer> x | (\exists BRelation<Pair<Integer,Integer>,Integer> e; (BRelation.cross(new BSet<Integer>(position_q),new Enumerated(position_s,new Integer(new Integer(position_s + machine.vehicle_slot.apply(vehicle_type)) - 1))).has(null)); e.equals(new Pair<Integer,ERROR>(null,vehicle_id)))}))))); 
	 also
		requires !guard_BoardLift(vehicle_id,vehicle_type,position_q,position_s);
		assignable \nothing;
		ensures true; */
	public void run_BoardLift( Integer vehicle_id, Integer vehicle_type, Integer position_q, Integer position_s){
		if(guard_BoardLift(vehicle_id,vehicle_type,position_q,position_s)) {
			Integer bs_m_tmp = machine.get_bs_m();
			BSet<Integer> auth_on_ids_tmp = machine.get_auth_on_ids();
			BSet<Integer> in_lift_ids_tmp = machine.get_in_lift_ids();
			BSet<Integer> boarded_ids_tmp = machine.get_boarded_ids();
			BRelation<Pair<Integer,Integer>,Integer> lift_vehicles_tmp = machine.get_lift_vehicles();

			machine.set_bs_m(new Integer(machine.vehicle_slot.apply(vehicle_type) + bs_m_tmp));
			machine.set_auth_on_ids(auth_on_ids_tmp.difference(new BSet<Integer>(vehicle_id)));
			machine.set_in_lift_ids((in_lift_ids_tmp.union(new BSet<Integer>(vehicle_id))));
			machine.set_boarded_ids(boarded_ids_tmp.insert(vehicle_id));
			
			// La génération par défaut pose problème:
			//machine.set_lift_vehicles((lift_vehicles_tmp.union(new BRelation<Pair<Integer,Integer>,Integer>(new JMLObjectSet {Pair<Integer,Integer> x | (\exists BRelation<Pair<Integer,Integer>,Integer> e; (BRelation.cross(new BSet<Integer>(position_q),new Enumerated(position_s,new Integer(new Integer(position_s + machine.vehicle_slot.apply(vehicle_type)) - 1))).has(null)); e.equals(new Pair<Integer,ERROR>(null,vehicle_id)))}))));
			// On la redéfinit comme suit:
			lift_vehicles_tmp.add(new Pair<Integer, Integer>(position_q, position_s), vehicle_id);
			machine.set_lift_vehicles(lift_vehicles_tmp);

			System.out.println("BoardLift executed vehicle_id: " + vehicle_id + " vehicle_type: " + vehicle_type + " position_q: " + position_q + " position_s: " + position_s + " ");
		}
	}

}
