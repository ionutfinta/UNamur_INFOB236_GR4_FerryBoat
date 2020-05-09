package ferryBoat_sequential; 

import eventb_prelude.*;
import Util.Utilities;

public class Boat_ready{
	/*@ spec_public */ private fifthRef machine; // reference to the machine 

	/*@ public normal_behavior
		requires true;
		assignable \everything;
		ensures this.machine == m; */
	public Boat_ready(fifthRef m) {
		this.machine = m;
	}

	/*@ public normal_behavior
		requires true;
 		assignable \nothing;
		ensures \result <==> ( capacities.domain().equals(machine.floors) && capacities.range().isSubset(NAT.instance) && capacities.isaFunction() && BRelation.cross(machine.floors,NAT.instance).has(capacities) && !capacities.range().equals(new BSet<Integer>(new Integer(0))) &&  (\forall Integer x;((machine.floors.has(x)) ==> (machine.get_max_bs_p().apply(x).equals(new Integer(0))))) &&  (\forall Integer x;((machine.floors.has(x)) ==> (machine.get_bs_p().apply(x).equals(new Integer(0))))) && machine.get_reserved_spaces().isSubset(new BRelation<Integer,Integer>(new JMLObjectSet {Integer f | (\exists BRelation<Integer,Integer> e; (machine.floors.has(f)); e.equals(new Pair<Integer,Integer>(f,new Integer(0))))}))); */
	public /*@ pure */ boolean guard_Boat_ready( BRelation<Integer,Integer> capacities) {
		return ( capacities.domain().equals(machine.floors) && capacities.range().isSubset(NAT.instance) && capacities.isaFunction() && BRelation.cross(machine.floors,NAT.instance).has(capacities) && !capacities.range().equals(new BSet<Integer>(new Integer(0))) && true && true && true);
	}

	/*@ public normal_behavior
		requires guard_Boat_ready(capacities);
		assignable machine.max_busy_slots, machine.max_bs_p;
		ensures guard_Boat_ready(capacities) &&  machine.get_max_busy_slots() == \old(machine.integral.apply(capacities)) &&  machine.get_max_bs_p().equals(\old(capacities)); 
	 also
		requires !guard_Boat_ready(capacities);
		assignable \nothing;
		ensures true; */
	public void run_Boat_ready( BRelation<Integer,Integer> capacities){
		if(guard_Boat_ready(capacities)) {
			Integer max_busy_slots_tmp = machine.get_max_busy_slots();
			BRelation<Integer,Integer> max_bs_p_tmp = machine.get_max_bs_p();

			machine.set_max_busy_slots(machine.integral(capacities));
			machine.set_max_bs_p(capacities);

			System.out.println("Boat_ready executed capacities: " + capacities + " ");
		}
	}

}
