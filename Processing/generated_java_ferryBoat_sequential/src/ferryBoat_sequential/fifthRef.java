package ferryBoat_sequential;

import eventb_prelude.*;
import Util.*;
//@ model import org.jmlspecs.models.JMLObjectSet;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class fifthRef{
	private static final Integer max_integer = Utilities.max_integer;
	private static final Integer min_integer = Utilities.min_integer;

	BoardLift evt_BoardLift = new BoardLift(this);
	Reserve evt_Reserve = new Reserve(this);
	Switch_lift_access evt_Switch_lift_access = new Switch_lift_access(this);
	Sensor_stops_detecting evt_Sensor_stops_detecting = new Sensor_stops_detecting(this);
	MoveLift evt_MoveLift = new MoveLift(this);
	Vehicle_auth_on evt_Vehicle_auth_on = new Vehicle_auth_on(this);
	Boat_leave evt_Boat_leave = new Boat_leave(this);
	Switch_lvl_2_access evt_Switch_lvl_2_access = new Switch_lvl_2_access(this);
	Sensor_detects evt_Sensor_detects = new Sensor_detects(this);
	Switch_lvl_1_access evt_Switch_lvl_1_access = new Switch_lvl_1_access(this);
	Switch_lvl_3_access evt_Switch_lvl_3_access = new Switch_lvl_3_access(this);
	LeaveLift evt_LeaveLift = new LeaveLift(this);
	Unboard evt_Unboard = new Unboard(this);
	Board evt_Board = new Board(this);
	Switch_lift_out evt_Switch_lift_out = new Switch_lift_out(this);
	Boat_ready evt_Boat_ready = new Boat_ready(this);
	Vehicle_in evt_Vehicle_in = new Vehicle_in(this);
	Vehicle_out evt_Vehicle_out = new Vehicle_out(this);
	Switch_lift_in evt_Switch_lift_in = new Switch_lift_in(this);


	/******Set definitions******/
	//@ public static constraint VEHICLE_TYPES.equals(\old(VEHICLE_TYPES)); 
	public static final BSet<Integer> VEHICLE_TYPES = new Enumerated(10,13);

	//@ public static constraint SENS_STATES.equals(\old(SENS_STATES)); 
	public static final BSet<Integer> SENS_STATES = new Enumerated(0,1);


	/******Constant definitions******/
	//@ public static constraint camion_1.equals(\old(camion_1)); 
	public static final Integer camion_1 = 11;

	//@ public static constraint camion_2.equals(\old(camion_2)); 
	public static final Integer camion_2 = 12;

	//@ public static constraint camion_3.equals(\old(camion_3)); 
	public static final Integer camion_3 = 13;

	//@ public static constraint vehicle_slot.equals(\old(vehicle_slot)); 
	public static final BRelation<Integer,Integer> vehicle_slot = new BRelation<Integer,Integer>().insert(10,1).insert(11,1).insert(12,2).insert(13,3);

	//@ public static constraint voiture.equals(\old(voiture)); 
	public static final Integer voiture = 10;

	//@ public static constraint floors.equals(\old(floors)); 
	public static final BSet<Integer> floors = new BSet<Integer>(1,2,3);

	//@ public static constraint max_bs_m.equals(\old(max_bs_m)); 
	public static final Integer max_bs_m = 6;

	//@ public static constraint lift_depth.equals(\old(lift_depth)); 
	public static final Integer lift_depth = 3;

	//@ public static constraint queues.equals(\old(queues)); 
	public static final Integer queues = 2;

	//@ public static constraint Detecting.equals(\old(Detecting)); 
	public static final Integer Detecting = 0;

	//@ public static constraint Not_Detecting.equals(\old(Not_Detecting)); 
	public static final Integer Not_Detecting = 1;



	/******Axiom definitions******/
	/*@ public static invariant BSet.partition(VEHICLE_TYPES,new BSet<Integer>(voiture),new BSet<Integer>(camion_1),new BSet<Integer>(camion_2),new BSet<Integer>(camion_3)); */
	/*@ public static invariant vehicle_slot.equals(new BRelation<Integer,Integer>(new Pair<Integer,Integer>(voiture,new Integer(1)),new Pair<Integer,Integer>(camion_1,new Integer(1)),new Pair<Integer,Integer>(camion_2,new Integer(2)),new Pair<Integer,Integer>(camion_3,new Integer(3)))); */
	/*@ public static invariant_redundantly vehicle_slot.range().equals(new BSet<Integer>(new Integer(1),new Integer(2),new Integer(3))); */
	/*@ public static invariant integral.equals((new BRelation<BRelation<Integer,Integer>,Integer>(new JMLObjectSet {BRelation<Integer,Integer> x | (\exists BRelation<BRelation<Integer,Integer>,Integer> e; (x.equals(BSet.EMPTY)); e.equals(new Pair<BRelation<Integer,Integer>,Integer>(x,new Integer(0))))}).union(new no_type(new JMLObjectSet {BRelation<Integer,Integer> x | (\exists no_type e; ( x.domain().isSubset(INT.instance) && x.range().isSubset(INT.instance) && x.isaFunction() && BRelation.cross(INT.instance,INT.instance).has(x) && x.finite() && (new Integer(x.size())).compareTo(new Integer(0)) > 0 && x.domain().finite()); e.equals(new Pair<BRelation<Integer,Integer>,Integer>(x,new Integer(integral.apply(x.difference(new BRelation<Integer,Integer>(new Pair<BRelation<Integer,Integer>,Integer>(x.domain().max(),x.apply(x.domain().max()))))) + x.apply(x.domain().max())))))})))); */
	/*@ public static invariant max_bs_m.equals(new Integer(6)); */
	/*@ public static invariant floors.equals(new Enumerated(new Integer(1),new Integer(3))); */
	/*@ public static invariant queues.equals(new Integer(2)); */
	/*@ public static invariant lift_depth.equals(new Integer(3)); */
	/*@ public static invariant BSet.partition(SENS_STATES,new BSet<Integer>(Detecting),new BSet<Integer>(Not_Detecting)); */


	/******Variable definitions******/
	/*@ spec_public */ private BRelation<Integer,Integer> Sensor_state;

	/*@ spec_public */ private BSet<Integer> auth_on_ids;

	/*@ spec_public */ private BSet<Integer> boarded_ids;

	/*@ spec_public */ private Integer bs_m;

	/*@ spec_public */ private BRelation<Integer,Integer> bs_p;

	/*@ spec_public */ private Integer busy_slots;

	/*@ spec_public */ private BRelation<Integer,Boolean> id_is_left;

	/*@ spec_public */ private BSet<Integer> in_lift_ids;

	/*@ spec_public */ private Boolean lift_access;

	/*@ spec_public */ private Boolean lift_in;

	/*@ spec_public */ private Integer lift_level;

	/*@ spec_public */ private Boolean lift_out;

	/*@ spec_public */ private BRelation<Pair<Integer,Integer>,Integer> lift_vehicles;

	/*@ spec_public */ private Boolean lvl_1_access;

	/*@ spec_public */ private Boolean lvl_2_access;

	/*@ spec_public */ private Boolean lvl_3_access;

	/*@ spec_public */ private BRelation<Integer,Integer> max_bs_p;

	/*@ spec_public */ private Integer max_busy_slots;

	/*@ spec_public */ private Boolean queue1;

	/*@ spec_public */ private Boolean queue2;

	/*@ spec_public */ private BRelation<Integer,Pair<Integer,Integer>> reservations;

	/*@ spec_public */ private BRelation<Integer,Integer> reserved_spaces;




	/******Invariant definition******/
	/*@ public invariant
		NAT.instance.has(max_busy_slots) &&
		NAT.instance.has(busy_slots) &&
		(busy_slots).compareTo(max_busy_slots) <= 0 &&
		 max_bs_p.domain().equals(floors) && max_bs_p.range().isSubset(NAT.instance) && max_bs_p.isaFunction() && BRelation.cross(floors,NAT.instance).has(max_bs_p) &&
		 bs_p.domain().equals(floors) && bs_p.range().isSubset(NAT.instance) && bs_p.isaFunction() && BRelation.cross(floors,NAT.instance).has(bs_p) &&
		 (\forall Integer x;((floors.has(x)) ==> ((bs_p.apply(x)).compareTo(max_bs_p.apply(x)) <= 0))) &&
		max_busy_slots.equals(integral.apply(max_bs_p)) &&
		busy_slots.equals(integral.apply(bs_p)) &&
		floors.has(lift_level) &&
		NAT.instance.has(bs_m) && (bs_m).compareTo(max_bs_m) <= 0 &&
		 reservations.domain().isSubset(NAT.instance) && reservations.range().isSubset(BRelation.cross(floors,VEHICLE_TYPES)) && reservations.isaFunction() && BRelation.cross(NAT.instance,BRelation.cross(floors,VEHICLE_TYPES)).has(reservations) &&
		 reserved_spaces.domain().equals(floors) && reserved_spaces.range().isSubset(NAT.instance) && reserved_spaces.isaFunction() && BRelation.cross(floors,NAT.instance).has(reserved_spaces) &&
		auth_on_ids.isSubset(NAT.instance) &&
		in_lift_ids.isSubset(NAT1.instance) &&
		boarded_ids.isSubset(NAT.instance) &&
		BOOL.instance.has(queue1) &&
		BOOL.instance.has(queue2) &&
		 lift_vehicles.domain().isSubset(BRelation.cross(new Enumerated(new Integer(1),queues),new Enumerated(new Integer(1),lift_depth))) && lift_vehicles.range().isSubset(NAT.instance) && lift_vehicles.isaFunction() && BRelation.cross(BRelation.cross(new Enumerated(new Integer(1),queues),new Enumerated(new Integer(1),lift_depth)),NAT.instance).has(lift_vehicles) &&
		 id_is_left.domain().isSubset(NAT.instance) && id_is_left.range().isSubset(BOOL.instance) && id_is_left.isaFunction() && BRelation.cross(NAT.instance,BOOL.instance).has(id_is_left) &&
		BOOL.instance.has(lift_in) &&
		BOOL.instance.has(lift_out) &&
		BOOL.instance.has(lvl_1_access) &&
		BOOL.instance.has(lvl_2_access) &&
		BOOL.instance.has(lvl_3_access) &&
		BOOL.instance.has(lift_access) &&
		 Sensor_state.domain().equals(floors) && Sensor_state.range().isSubset(SENS_STATES) && Sensor_state.isaFunction() && BRelation.cross(floors,SENS_STATES).has(Sensor_state) &&
		(new Integer(new no_type(new JMLObjectSet {Integer floor | (\exists no_type e; (new Enumerated(new Integer(1),new Integer(3)).has(floor) && Sensor_state.apply(floor).equals(Detecting)); e.equals(floor))}).size())).compareTo(new Integer(1)) <= 0; */


	/******Getter and Mutator methods definition******/
	/*@ public normal_behavior
	    requires true;
	    assignable \nothing;
	    ensures \result == this.lvl_1_access;*/
	public /*@ pure */ Boolean get_lvl_1_access(){
		return this.lvl_1_access;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable this.lvl_1_access;
	    ensures this.lvl_1_access == lvl_1_access;*/
	public void set_lvl_1_access(Boolean lvl_1_access){
		this.lvl_1_access = lvl_1_access;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable \nothing;
	    ensures \result == this.lvl_2_access;*/
	public /*@ pure */ Boolean get_lvl_2_access(){
		return this.lvl_2_access;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable this.lvl_2_access;
	    ensures this.lvl_2_access == lvl_2_access;*/
	public void set_lvl_2_access(Boolean lvl_2_access){
		this.lvl_2_access = lvl_2_access;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable \nothing;
	    ensures \result == this.Sensor_state;*/
	public /*@ pure */ BRelation<Integer,Integer> get_Sensor_state(){
		return this.Sensor_state;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable this.Sensor_state;
	    ensures this.Sensor_state == Sensor_state;*/
	public void set_Sensor_state(BRelation<Integer,Integer> Sensor_state){
		this.Sensor_state = Sensor_state;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable \nothing;
	    ensures \result == this.lift_level;*/
	public /*@ pure */ Integer get_lift_level(){
		return this.lift_level;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable this.lift_level;
	    ensures this.lift_level == lift_level;*/
	public void set_lift_level(Integer lift_level){
		this.lift_level = lift_level;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable \nothing;
	    ensures \result == this.auth_on_ids;*/
	public /*@ pure */ BSet<Integer> get_auth_on_ids(){
		return this.auth_on_ids;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable this.auth_on_ids;
	    ensures this.auth_on_ids == auth_on_ids;*/
	public void set_auth_on_ids(BSet<Integer> auth_on_ids){
		this.auth_on_ids = auth_on_ids;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable \nothing;
	    ensures \result == this.lift_vehicles;*/
	public /*@ pure */ BRelation<Pair<Integer,Integer>,Integer> get_lift_vehicles(){
		return this.lift_vehicles;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable this.lift_vehicles;
	    ensures this.lift_vehicles == lift_vehicles;*/
	public void set_lift_vehicles(BRelation<Pair<Integer,Integer>,Integer> lift_vehicles){
		this.lift_vehicles = lift_vehicles;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable \nothing;
	    ensures \result == this.lift_access;*/
	public /*@ pure */ Boolean get_lift_access(){
		return this.lift_access;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable this.lift_access;
	    ensures this.lift_access == lift_access;*/
	public void set_lift_access(Boolean lift_access){
		this.lift_access = lift_access;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable \nothing;
	    ensures \result == this.bs_p;*/
	public /*@ pure */ BRelation<Integer,Integer> get_bs_p(){
		return this.bs_p;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable this.bs_p;
	    ensures this.bs_p == bs_p;*/
	public void set_bs_p(BRelation<Integer,Integer> bs_p){
		this.bs_p = bs_p;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable \nothing;
	    ensures \result == this.busy_slots;*/
	public /*@ pure */ Integer get_busy_slots(){
		return this.busy_slots;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable this.busy_slots;
	    ensures this.busy_slots == busy_slots;*/
	public void set_busy_slots(Integer busy_slots){
		this.busy_slots = busy_slots;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable \nothing;
	    ensures \result == this.reserved_spaces;*/
	public /*@ pure */ BRelation<Integer,Integer> get_reserved_spaces(){
		return this.reserved_spaces;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable this.reserved_spaces;
	    ensures this.reserved_spaces == reserved_spaces;*/
	public void set_reserved_spaces(BRelation<Integer,Integer> reserved_spaces){
		this.reserved_spaces = reserved_spaces;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable \nothing;
	    ensures \result == this.boarded_ids;*/
	public /*@ pure */ BSet<Integer> get_boarded_ids(){
		return this.boarded_ids;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable this.boarded_ids;
	    ensures this.boarded_ids == boarded_ids;*/
	public void set_boarded_ids(BSet<Integer> boarded_ids){
		this.boarded_ids = boarded_ids;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable \nothing;
	    ensures \result == this.bs_m;*/
	public /*@ pure */ Integer get_bs_m(){
		return this.bs_m;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable this.bs_m;
	    ensures this.bs_m == bs_m;*/
	public void set_bs_m(Integer bs_m){
		this.bs_m = bs_m;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable \nothing;
	    ensures \result == this.lift_out;*/
	public /*@ pure */ Boolean get_lift_out(){
		return this.lift_out;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable this.lift_out;
	    ensures this.lift_out == lift_out;*/
	public void set_lift_out(Boolean lift_out){
		this.lift_out = lift_out;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable \nothing;
	    ensures \result == this.in_lift_ids;*/
	public /*@ pure */ BSet<Integer> get_in_lift_ids(){
		return this.in_lift_ids;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable this.in_lift_ids;
	    ensures this.in_lift_ids == in_lift_ids;*/
	public void set_in_lift_ids(BSet<Integer> in_lift_ids){
		this.in_lift_ids = in_lift_ids;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable \nothing;
	    ensures \result == this.max_busy_slots;*/
	public /*@ pure */ Integer get_max_busy_slots(){
		return this.max_busy_slots;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable this.max_busy_slots;
	    ensures this.max_busy_slots == max_busy_slots;*/
	public void set_max_busy_slots(Integer max_busy_slots){
		this.max_busy_slots = max_busy_slots;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable \nothing;
	    ensures \result == this.queue1;*/
	public /*@ pure */ Boolean get_queue1(){
		return this.queue1;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable this.queue1;
	    ensures this.queue1 == queue1;*/
	public void set_queue1(Boolean queue1){
		this.queue1 = queue1;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable \nothing;
	    ensures \result == this.reservations;*/
	public /*@ pure */ BRelation<Integer,Pair<Integer,Integer>> get_reservations(){
		return this.reservations;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable this.reservations;
	    ensures this.reservations == reservations;*/
	public void set_reservations(BRelation<Integer,Pair<Integer,Integer>> reservations){
		this.reservations = reservations;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable \nothing;
	    ensures \result == this.queue2;*/
	public /*@ pure */ Boolean get_queue2(){
		return this.queue2;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable this.queue2;
	    ensures this.queue2 == queue2;*/
	public void set_queue2(Boolean queue2){
		this.queue2 = queue2;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable \nothing;
	    ensures \result == this.max_bs_p;*/
	public /*@ pure */ BRelation<Integer,Integer> get_max_bs_p(){
		return this.max_bs_p;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable this.max_bs_p;
	    ensures this.max_bs_p == max_bs_p;*/
	public void set_max_bs_p(BRelation<Integer,Integer> max_bs_p){
		this.max_bs_p = max_bs_p;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable \nothing;
	    ensures \result == this.lift_in;*/
	public /*@ pure */ Boolean get_lift_in(){
		return this.lift_in;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable this.lift_in;
	    ensures this.lift_in == lift_in;*/
	public void set_lift_in(Boolean lift_in){
		this.lift_in = lift_in;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable \nothing;
	    ensures \result == this.id_is_left;*/
	public /*@ pure */ BRelation<Integer,Boolean> get_id_is_left(){
		return this.id_is_left;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable this.id_is_left;
	    ensures this.id_is_left == id_is_left;*/
	public void set_id_is_left(BRelation<Integer,Boolean> id_is_left){
		this.id_is_left = id_is_left;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable \nothing;
	    ensures \result == this.lvl_3_access;*/
	public /*@ pure */ Boolean get_lvl_3_access(){
		return this.lvl_3_access;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable this.lvl_3_access;
	    ensures this.lvl_3_access == lvl_3_access;*/
	public void set_lvl_3_access(Boolean lvl_3_access){
		this.lvl_3_access = lvl_3_access;
	}

	public Integer integral(BRelation<Integer, Integer> in) {
		int res = 0;
		for(Integer x:in.domain()) {
			res += in.apply(x);
		}
		return res;
	}

	/*@ public normal_behavior
	    requires true;
	    assignable \everything;
	    ensures
		max_busy_slots == 0 &&
		busy_slots == 0 &&
		max_bs_p == new no_type(new JMLObjectSet {Integer f | (\exists no_type e; (floors.has(null)); e.equals(new Pair<Integer,ERROR>(null,0)))}) &&
		bs_p == new no_type(new JMLObjectSet {Integer f | (\exists no_type e; (floors.has(null)); e.equals(new Pair<Integer,ERROR>(null,0)))}) &&
		lift_level == 1 &&
		bs_m == 0 &&
		reservations.isEmpty() &&
		reserved_spaces == new no_type(new JMLObjectSet {Integer f | (\exists no_type e; (floors.has(null)); e.equals(new Pair<Integer,ERROR>(null,0)))}) &&
		auth_on_ids.isEmpty() &&
		in_lift_ids.isEmpty() &&
		boarded_ids.isEmpty() &&
		queue1 == false &&
		queue2 == false &&
		lift_vehicles.isEmpty() &&
		id_is_left.isEmpty() &&
		lift_in == false &&
		lift_out == false &&
		lvl_1_access == false &&
		lvl_2_access == false &&
		lvl_3_access == false &&
		lift_access == false &&
		Sensor_state.equals(new BRelation<Integer,Integer>(new Pair<Integer,Integer>(1,Detecting),new Pair<Integer,Integer>(2,Not_Detecting),new Pair<Integer,Integer>(3,Not_Detecting)));*/
	public fifthRef(){
		max_busy_slots = 0;
		busy_slots = 0;
		
		BRelation<Integer, Integer> eachfloor0 = new BRelation<Integer, Integer>();
		for(int  i = 0; i <= floors.max(); i++) {
			eachfloor0.insert(i, 0);
		}
		//max_bs_p = new no_type(new JMLObjectSet {Integer f | (\exists no_type e; (floors.has(null)); e.equals(new Pair<Integer,ERROR>(null,0)))});
		max_bs_p = eachfloor0;
		//bs_p = new no_type(new JMLObjectSet {Integer f | (\exists no_type e; (floors.has(null)); e.equals(new Pair<Integer,ERROR>(null,0)))});
		bs_p  = eachfloor0;
		lift_level = 1;
		bs_m = 0;
		reservations = new BRelation<Integer,Pair<Integer,Integer>>();
		//reserved_spaces = new no_type(new JMLObjectSet {Integer f | (\exists no_type e; (floors.has(null)); e.equals(new Pair<Integer,ERROR>(null,0)))});
		reserved_spaces = eachfloor0;
		auth_on_ids = new BSet<Integer>();
		in_lift_ids = new BSet<Integer>();
		boarded_ids = new BSet<Integer>();
		queue1 = false;
		queue2 = false;
		lift_vehicles = new BRelation<Pair<Integer,Integer>,Integer>();
		id_is_left = new BRelation<Integer,Boolean>();
		lift_in = false;
		lift_out = false;
		lvl_1_access = false;
		lvl_2_access = false;
		lvl_3_access = false;
		lift_access = false;
		Sensor_state = new BRelation<Integer,Integer>(new Pair<Integer,Integer>(1,Detecting),new Pair<Integer,Integer>(2,Not_Detecting),new Pair<Integer,Integer>(3,Not_Detecting));

	}
}