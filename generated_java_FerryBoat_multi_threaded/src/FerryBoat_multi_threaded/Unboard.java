package FerryBoat_multi_threaded; 

import eventb_prelude.*;
import Util.Utilities;

public class Unboard extends Thread{
	/*@ spec_public */ private fifthRef machine; // reference to the machine 

	/*@ public normal_behavior
		requires true;
		assignable \everything;
		ensures this.machine == m; */
	public Unboard(fifthRef m) {
		this.machine = m;
	}

	/*@ public normal_behavior
		requires true;
 		assignable \nothing;
		ensures \result <==> (machine.VEHICLE_TYPES.has(vehicle_type) && (machine.vehicle_slot.apply(vehicle_type)).compareTo(machine.get_busy_slots()) <= 0 && (new Integer(machine.get_bs_m() + machine.vehicle_slot.apply(vehicle_type))).compareTo(machine.max_bs_m) <= 0 && machine.get_lift_level().equals(new Integer(1)) && (machine.vehicle_slot.apply(vehicle_type)).compareTo(machine.get_bs_p().apply(machine.get_lift_level())) <= 0 && machine.get_reservations().domain().difference(new BSet<Integer>(new Integer(0))).has(vehicle_id) && new Integer(new JMLObjectSet {Integer fInteger v | (exists Integer e; (machine.floors.has(f) && v.equals(vehicle_type)); e.equals(new Pair<Integer,Integer>(f,v)))}).has(machine.get_reservations().apply(vehicle_id)) && machine.get_boarded_ids().has(vehicle_id) && new Enumerated(new Integer(1),machine.queues).has(position_q) && ((machine.get_id_is_left().apply(vehicle_id).equals(true)) ==> (position_q.equals(new Integer(1)))) && ((machine.get_id_is_left().apply(vehicle_id).equals(false)) ==> (position_q.equals(new Integer(2)))) && new Enumerated(machine.vehicle_slot.apply(vehicle_type),machine.lift_depth).has(position_s) && position_s.equals((new BSet<Integer>(new Integer(0)).union(new Integer(new JMLObjectSet {Integer x | (\exists Integer e; (new Enumerated(new Integer(1),machine.lift_depth).has(x) && (x).compareTo((new BSet<Integer>(machine.lift_depth).union(new Integer(new JMLObjectSet {Integer y | (\exists Integer e; (new Enumerated(new Integer(1),machine.lift_depth).has(y) && machine.get_lift_vehicles().domain().has(new Pair<Integer,Integer>(position_q,y))); e.equals(y))}))).min()) <= 0); e.equals(x))}))).max()) && machine.get_lift_out().equals(true) && ((machine.get_lift_level().equals(new Integer(1))) ==> (machine.get_lvl_1_access().equals(true))) && ((machine.get_lift_level().equals(new Integer(2))) ==> (machine.get_lvl_2_access().equals(true))) && ((machine.get_lift_level().equals(new Integer(3))) ==> (machine.get_lvl_3_access().equals(true))) && machine.get_Sensor_state().apply(machine.get_lift_level()).equals(machine.Detecting)); */
	public /*@ pure */ boolean guard_Unboard( Integer vehicle_id, Integer vehicle_type, Integer position_q, Integer position_s) {
		return (machine.VEHICLE_TYPES.has(vehicle_type) && (machine.vehicle_slot.apply(vehicle_type)).compareTo(machine.get_busy_slots()) <= 0 && (new Integer(machine.get_bs_m() + machine.vehicle_slot.apply(vehicle_type))).compareTo(machine.max_bs_m) <= 0 && machine.get_lift_level().equals(new Integer(1)) && (machine.vehicle_slot.apply(vehicle_type)).compareTo(machine.get_bs_p().apply(machine.get_lift_level())) <= 0 && machine.get_reservations().domain().difference(new BSet<Integer>(new Integer(0))).has(vehicle_id) && new Integer(new JMLObjectSet {Integer fInteger v | (exists Integer e; (machine.floors.has(f) && v.equals(vehicle_type)); e.equals(new Pair<Integer,Integer>(f,v)))}).has(machine.get_reservations().apply(vehicle_id)) && machine.get_boarded_ids().has(vehicle_id) && new Enumerated(new Integer(1),machine.queues).has(position_q) && BOOL.implication(machine.get_id_is_left().apply(vehicle_id).equals(true),position_q.equals(new Integer(1))) && BOOL.implication(machine.get_id_is_left().apply(vehicle_id).equals(false),position_q.equals(new Integer(2))) && new Enumerated(machine.vehicle_slot.apply(vehicle_type),machine.lift_depth).has(position_s) && true && machine.get_lift_out().equals(true) && BOOL.implication(machine.get_lift_level().equals(new Integer(1)),machine.get_lvl_1_access().equals(true)) && BOOL.implication(machine.get_lift_level().equals(new Integer(2)),machine.get_lvl_2_access().equals(true)) && BOOL.implication(machine.get_lift_level().equals(new Integer(3)),machine.get_lvl_3_access().equals(true)) && machine.get_Sensor_state().apply(machine.get_lift_level()).equals(machine.Detecting));
	}

	/*@ public normal_behavior
		requires guard_Unboard(vehicle_id,vehicle_type,position_q,position_s);
		assignable machine.busy_slots, machine.bs_m, machine.bs_p, machine.in_lift_ids, machine.boarded_ids, machine.lift_vehicles;
		ensures guard_Unboard(vehicle_id,vehicle_type,position_q,position_s) &&  machine.get_busy_slots() == \old(new Integer(machine.get_busy_slots() - machine.vehicle_slot.apply(vehicle_type))) &&  machine.get_bs_m() == \old(new Integer(machine.get_bs_m() + machine.vehicle_slot.apply(vehicle_type))) &&  machine.get_bs_p().equals(\old((machine.get_bs_p().override(new BRelation<Integer,Integer>(new Pair<Integer,Integer>(machine.get_lift_level(),new Integer(machine.get_bs_p().apply(machine.get_lift_level()) - machine.vehicle_slot.apply(vehicle_type)))))))) &&  machine.get_in_lift_ids().equals(\old((machine.get_in_lift_ids().union(new BSet<Integer>(vehicle_id))))) &&  machine.get_boarded_ids().equals(\old(machine.get_boarded_ids().difference(new BSet<Integer>(vehicle_id)))) &&  machine.get_lift_vehicles().equals(\old((machine.get_lift_vehicles().union(new BRelation<Pair<Integer,Integer>,Integer>(new JMLObjectSet {Pair<Integer,Integer> x | (\exists BRelation<Pair<Integer,Integer>,Integer> e; (BRelation.cross(new BSet<Integer>(position_q),new Enumerated(new Integer(new Integer(position_s - machine.vehicle_slot.apply(vehicle_type)) + 1),position_s)).has(null)); e.equals(new Pair<Integer,ERROR>(null,vehicle_id)))}))))); 
	 also
		requires !guard_Unboard(vehicle_id,vehicle_type,position_q,position_s);
		assignable \nothing;
		ensures true; */
	public void run_Unboard( Integer vehicle_id, Integer vehicle_type, Integer position_q, Integer position_s){
		if(guard_Unboard(vehicle_id,vehicle_type,position_q,position_s)) {
			Integer busy_slots_tmp = machine.get_busy_slots();
			Integer bs_m_tmp = machine.get_bs_m();
			BRelation<Integer,Integer> bs_p_tmp = machine.get_bs_p();
			BSet<Integer> in_lift_ids_tmp = machine.get_in_lift_ids();
			BSet<Integer> boarded_ids_tmp = machine.get_boarded_ids();
			BRelation<Pair<Integer,Integer>,Integer> lift_vehicles_tmp = machine.get_lift_vehicles();

			machine.set_busy_slots(new Integer(busy_slots_tmp - machine.vehicle_slot.apply(vehicle_type)));
			machine.set_bs_m(new Integer(bs_m_tmp + machine.vehicle_slot.apply(vehicle_type)));
			machine.set_bs_p((bs_p_tmp.override(new BRelation<Integer,Integer>(new Pair<Integer,Integer>(machine.get_lift_level(),new Integer(bs_p_tmp.apply(machine.get_lift_level()) - machine.vehicle_slot.apply(vehicle_type)))))));
			machine.set_in_lift_ids((in_lift_ids_tmp.union(new BSet<Integer>(vehicle_id))));
			machine.set_boarded_ids(boarded_ids_tmp.difference(new BSet<Integer>(vehicle_id)));
			machine.set_lift_vehicles((lift_vehicles_tmp.union(new BRelation<Pair<Integer,Integer>,Integer>(new JMLObjectSet {Pair<Integer,Integer> x | (\exists BRelation<Pair<Integer,Integer>,Integer> e; (BRelation.cross(new BSet<Integer>(position_q),new Enumerated(new Integer(new Integer(position_s - machine.vehicle_slot.apply(vehicle_type)) + 1),position_s)).has(null)); e.equals(new Pair<Integer,ERROR>(null,vehicle_id)))}))));

			System.out.println("Unboard executed vehicle_id: " + vehicle_id + " vehicle_type: " + vehicle_type + " position_q: " + position_q + " position_s: " + position_s + " ");
		}
	}

	public void run() {
		while(true) {
			Integer vehicle_id = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));
			Integer vehicle_type = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));
			Integer position_q = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));
			Integer position_s = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));
			machine.lock.lock(); // start of critical section
			run_Unboard(vehicle_id,vehicle_type,position_q,position_s);
			machine.lock.unlock(); // end of critical section
		}
	}
}
