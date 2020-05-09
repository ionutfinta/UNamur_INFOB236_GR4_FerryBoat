package ferryBoat_sequential; 

import eventb_prelude.*;
import Util.Utilities;

public class LeaveLift{
	/*@ spec_public */ private fifthRef machine; // reference to the machine 

	/*@ public normal_behavior
		requires true;
		assignable \everything;
		ensures this.machine == m; */
	public LeaveLift(fifthRef m) {
		this.machine = m;
	}

	/*@ public normal_behavior
		requires true;
 		assignable \nothing;
		ensures \result <==> (machine.get_lift_level().equals(new Integer(1)) && machine.VEHICLE_TYPES.has(vehicle_type) && (machine.get_bs_m()).compareTo(new Integer(0)) > 0 && (machine.vehicle_slot.apply(vehicle_type)).compareTo(machine.get_bs_m()) <= 0 && machine.get_reservations().domain().has(vehicle_id) && new Integer(new JMLObjectSet {Integer fInteger v | (exists Integer e; (machine.floors.has(f) && v.equals(vehicle_type)); e.equals(new Pair<Integer,Integer>(f,v)))}).has(machine.get_reservations().apply(vehicle_id)) && machine.get_lift_access().equals(true) && machine.get_lift_in().equals(true)); */
	public /*@ pure */ boolean guard_LeaveLift( Integer vehicle_id, Integer vehicle_type) {
		return (machine.get_lift_level().equals(new Integer(1)) // grd3_1
				&& machine.VEHICLE_TYPES.has(vehicle_type) //grd1_2
				&& (machine.get_bs_m()).compareTo(new Integer(0)) > 0 //grd1_2
				&& (machine.vehicle_slot.apply(vehicle_type)).compareTo(machine.get_bs_m()) <= 0 //grd2_2
				&& machine.get_reservations().domain().has(vehicle_id) //grd3_2
				//grd4_2 était déjà erronée en EventB: On exprime la même chose que grd3_2
				&& machine.get_lift_access().equals(true) 
				&& machine.get_lift_in().equals(true));
	}

	/*@ public normal_behavior
		requires guard_LeaveLift(vehicle_id,vehicle_type);
		assignable machine.bs_m, machine.in_lift_ids, machine.lift_vehicles, machine.boarded_ids;
		ensures guard_LeaveLift(vehicle_id,vehicle_type) &&  machine.get_bs_m() == \old(new Integer(machine.get_bs_m() - machine.vehicle_slot.apply(vehicle_type))) &&  machine.get_in_lift_ids().equals(\old(machine.get_in_lift_ids().difference(new BSet<Integer>(vehicle_id)))) &&  machine.get_lift_vehicles().equals(\old(machine.get_lift_vehicles().difference(new no_type(new JMLObjectSet {Pair<Integer,Integer> x | (\exists no_type e; (BRelation.cross(new Enumerated(1,machine.queues),new Enumerated(1,machine.lift_depth)).has(null) && machine.get_lift_vehicles().apply(null).equals(vehicle_id)); e.equals(new Pair<Integer,ERROR>(null,vehicle_id)))})))) &&  machine.get_boarded_ids().equals(\old(machine.get_boarded_ids().difference(new BSet<Integer>(vehicle_id)))); 
	 also
		requires !guard_LeaveLift(vehicle_id,vehicle_type);
		assignable \nothing;
		ensures true; */
	public void run_LeaveLift( Integer vehicle_id, Integer vehicle_type){
		if(guard_LeaveLift(vehicle_id,vehicle_type)) {
			Integer bs_m_tmp = machine.get_bs_m();
			BSet<Integer> in_lift_ids_tmp = machine.get_in_lift_ids();
			BRelation<Pair<Integer,Integer>,Integer> lift_vehicles_tmp = machine.get_lift_vehicles();
			BSet<Integer> boarded_ids_tmp = machine.get_boarded_ids();

			machine.set_bs_m(new Integer(bs_m_tmp - machine.vehicle_slot.apply(vehicle_type)));
			machine.set_in_lift_ids(in_lift_ids_tmp.difference(new BSet<Integer>(vehicle_id)));
			//Même souci que dans Board.java:
			//machine.set_lift_vehicles(lift_vehicles_tmp.difference(new Pair<Integer,Integer> x | (\exists no_type e; (BRelation.cross(new Enumerated(1,machine.queues),new Enumerated(1,machine.lift_depth)).has(null) && lift_vehicles_tmp.apply(null).equals(vehicle_id)); e.equals(new Pair<Integer,Integer>(null,vehicle_id)))})));
			for(Pair<Integer, Integer> k: lift_vehicles_tmp.inverseElementImage(vehicle_id)) {
				lift_vehicles_tmp.remove(k, vehicle_id);
			}
			machine.set_lift_vehicles(lift_vehicles_tmp);
			machine.set_boarded_ids(boarded_ids_tmp.difference(new BSet<Integer>(vehicle_id)));

			System.out.println("LeaveLift executed vehicle_id: " + vehicle_id + " vehicle_type: " + vehicle_type + " ");
		}
	}

}
