package ferryBoat_sequential;
import java.util.Random;
import Util.Utilities;
import eventb_prelude.*;

public class Test_fifthRef{

	public static Integer random_camion_2;
	public static Integer random_camion_3;
	public static Integer random_max_bs_m;
	public static BRelation<Integer,Integer> random_vehicle_slot;
	public static Integer random_voiture;
	public static BSet<Integer> random_floors;
	public static BRelation<BRelation<Integer,Integer>,Integer> random_integral;
	public static Integer random_queues;
	public static Integer random_Detecting;
	public static Integer random_camion_1;
	public static Integer random_lift_depth;
	public static Integer random_Not_Detecting;

	static Random rnd = new Random();
	static Integer max_size_BSet = 10;
	Integer min_integer = Utilities.min_integer;
	Integer max_integer = Utilities.max_integer;

	public Integer GenerateRandomInteger(){
		BSet<Integer> S =  new BSet<Integer>(
				new Enumerated(min_integer, max_integer)
				);
		/** User defined code that reflects axioms and theorems: Begin **/

		/** User defined code that reflects axioms and theorems: End **/

		return (Integer) S.toArray()[rnd.nextInt(S.size())];
	}

	public boolean GenerateRandomBoolean(){
		boolean res = (Boolean) BOOL.instance.toArray()[rnd.nextInt(2)];

		/** User defined code that reflects axioms and theorems: Begin **/

		/** User defined code that reflects axioms and theorems: End **/

		return res;
	}


	public BSet<Integer> GenerateRandomIntegerBSet(){
		int size = rnd.nextInt(max_size_BSet);
		BSet<Integer> S = new BSet<Integer>();
		while (S.size() != size){
			S.add(GenerateRandomInteger());
		}

		/** User defined code that reflects axioms and theorems: Begin **/

		/** User defined code that reflects axioms and theorems: End **/

		return S;
	}

	public BSet<Boolean> GenerateRandomBooleanBSet(){
		int size = rnd.nextInt(2);
		BSet<Boolean> res = new BSet<Boolean>();
		if (size == 0){
			res = new BSet<Boolean>(GenerateRandomBoolean());
		}else{
			res = new BSet<Boolean>(true,false);
		}

		/** User defined code that reflects axioms and theorems: Begin **/

		/** User defined code that reflects axioms and theorems: End **/

		return res;
	}

	public BRelation<Integer,Integer> GenerateRandomBRelation(){
		BRelation<Integer,Integer> res = new BRelation<Integer,Integer>();
		int size = rnd.nextInt(max_size_BSet);
		while (res.size() != size){
			res.add(
					new Pair<Integer, Integer>(GenerateRandomInteger(), GenerateRandomInteger()));
		}
		/** User defined code that reflects axioms and theorems: Begin **/

		/** User defined code that reflects axioms and theorems: End **/

		return res;
	}

	public static void main(String[] args){
		Test_fifthRef test = new Test_fifthRef();

		/** User defined code that reflects axioms and theorems: Begin **/
		test.random_camion_2 = test.GenerateRandomInteger();
		test.random_camion_3 = test.GenerateRandomInteger();
		test.random_max_bs_m = test.GenerateRandomInteger();
		test.random_vehicle_slot = test.GenerateRandomBRelation();
		test.random_voiture = test.GenerateRandomInteger();
		test.random_floors = test.GenerateRandomIntegerBSet();
		test.random_integral = test.GenerateRandomBRelation();
		test.random_queues = test.GenerateRandomInteger();
		test.random_Detecting = test.GenerateRandomInteger();
		test.random_camion_1 = test.GenerateRandomInteger();
		test.random_lift_depth = test.GenerateRandomInteger();
		test.random_Not_Detecting = test.GenerateRandomInteger();
		/** User defined code that reflects axioms and theorems: End **/

		fifthRef machine = new fifthRef();
		int n = 19; //the number of events in the machine
		//Init values for parameters in event: Boat_ready
		BRelation<Integer,Integer> capacities = null; //not supported yet

		//Init values for parameters in event: Board
		Integer vehicle_id_board = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));
		Integer vehicle_type_board = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));

		//Init values for parameters in event: Unboard
		Integer vehicle_id_unboard = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));
		Integer vehicle_type_unboard = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));
		Integer position_q_unboard = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));
		Integer position_s_unboard = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));

		//Init values for parameters in event: MoveLift
		Integer selected_level = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));

		//Init values for parameters in event: BoardLift
		Integer vehicle_id_boardlift = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));
		Integer vehicle_type_boardlift = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));
		Integer position_q_boardlift = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));
		Integer position_s_boardlift = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));

		//Init values for parameters in event: LeaveLift
		Integer vehicle_id_leave_lift = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));
		Integer vehicle_type_leave_lift = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));

		//Init values for parameters in event: Reserve
		Integer floor = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));
		Integer vehicle_type_reserve = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));

		//Init values for parameters in event: Vehicle_auth_on
		Integer vehicle_id_auth = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));
		Integer vehicle_type_auth = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));
		Boolean is_left = Utilities.someVal(new BSet<Boolean>((true,false)));

		//Init values for parameters in event: Vehicle_in
		Boolean queue_1_in = Utilities.someVal(new BSet<Boolean>((true,false)));
		Boolean queue_2_in = Utilities.someVal(new BSet<Boolean>((true,false)));

		//Init values for parameters in event: Vehicle_out
		Boolean queue_1_out = Utilities.someVal(new BSet<Boolean>((true,false)));
		Boolean queue_2_out = Utilities.someVal(new BSet<Boolean>((true,false)));

		//Init values for parameters in event: Switch_lift_in
		Boolean bsli = Utilities.someVal(new BSet<Boolean>((true,false)));

		//Init values for parameters in event: Switch_lift_out
		Boolean bslo = Utilities.someVal(new BSet<Boolean>((true,false)));

		//Init values for parameters in event: Switch_lvl_1_access
		Boolean bs1a = Utilities.someVal(new BSet<Boolean>((true,false)));

		//Init values for parameters in event: Switch_lvl_2_access
		Boolean bs2a = Utilities.someVal(new BSet<Boolean>((true,false)));

		//Init values for parameters in event: Switch_lvl_3_access
		Boolean bs3a = Utilities.someVal(new BSet<Boolean>((true,false)));

		//Init values for parameters in event: Switch_lift_access
		Boolean bsla = Utilities.someVal(new BSet<Boolean>((true,false)));

		//Init values for parameters in event: Sensor_detects
		Integer sensor_detects = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));

		//Init values for parameters in event: Sensor_stops_detecting
		Integer sensor_stops = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));

		while (true){
			switch (rnd.nextInt(n)){
			case 0: if (machine.evt_Boat_ready.guard_Boat_ready(capacities))
				machine.evt_Boat_ready.run_Boat_ready(capacities); break;
			case 1: if (machine.evt_Boat_leave.guard_Boat_leave())
				machine.evt_Boat_leave.run_Boat_leave(); break;
			case 2: if (machine.evt_Board.guard_Board(vehicle_id_board,vehicle_type_board))
				machine.evt_Board.run_Board(vehicle_id_board,vehicle_type_board); break;
			case 3: if (machine.evt_Unboard.guard_Unboard(vehicle_id_unboard,vehicle_type_unboard,position_q_unboard,position_s_unboard))
				machine.evt_Unboard.run_Unboard(vehicle_id_unboard,vehicle_type_unboard,position_q_unboard,position_s_unboard); break;
			case 4: if (machine.evt_MoveLift.guard_MoveLift(selected_level))
				machine.evt_MoveLift.run_MoveLift(selected_level); break;
			case 5: if (machine.evt_BoardLift.guard_BoardLift(vehicle_id_boardlift,vehicle_type_boardlift,position_q_boardlift,position_s_boardlift))
				machine.evt_BoardLift.run_BoardLift(vehicle_id_boardlift,vehicle_type_boardlift,position_q_boardlift,position_s_boardlift); break;
			case 6: if (machine.evt_LeaveLift.guard_LeaveLift(vehicle_id_leave_lift,vehicle_type_leave_lift))
				machine.evt_LeaveLift.run_LeaveLift(vehicle_id_leave_lift,vehicle_type_leave_lift); break;
			case 7: if (machine.evt_Reserve.guard_Reserve(floor,vehicle_type_reserve))
				machine.evt_Reserve.run_Reserve(floor,vehicle_type_reserve); break;
			case 8: if (machine.evt_Vehicle_auth_on.guard_Vehicle_auth_on(vehicle_id_auth,vehicle_type_auth,is_left))
				machine.evt_Vehicle_auth_on.run_Vehicle_auth_on(vehicle_id_auth,vehicle_type_auth,is_left); break;
			case 9: if (machine.evt_Vehicle_in.guard_Vehicle_in(queue_1_in,queue_2_in))
				machine.evt_Vehicle_in.run_Vehicle_in(queue_1_in,queue_2_in); break;
			case 10: if (machine.evt_Vehicle_out.guard_Vehicle_out(queue_1_out,queue_2_out))
				machine.evt_Vehicle_out.run_Vehicle_out(queue_1_out,queue_2_out); break;
			case 11: if (machine.evt_Switch_lift_in.guard_Switch_lift_in(bsli))
				machine.evt_Switch_lift_in.run_Switch_lift_in(bsli); break;
			case 12: if (machine.evt_Switch_lift_out.guard_Switch_lift_out(bslo))
				machine.evt_Switch_lift_out.run_Switch_lift_out(bslo); break;
			case 13: if (machine.evt_Switch_lvl_1_access.guard_Switch_lvl_1_access(bs1a))
				machine.evt_Switch_lvl_1_access.run_Switch_lvl_1_access(bs1a); break;
			case 14: if (machine.evt_Switch_lvl_2_access.guard_Switch_lvl_2_access(bs2a))
				machine.evt_Switch_lvl_2_access.run_Switch_lvl_2_access(bs2a); break;
			case 15: if (machine.evt_Switch_lvl_3_access.guard_Switch_lvl_3_access(bs3a))
				machine.evt_Switch_lvl_3_access.run_Switch_lvl_3_access(bs3a); break;
			case 16: if (machine.evt_Switch_lift_access.guard_Switch_lift_access(bsla))
				machine.evt_Switch_lift_access.run_Switch_lift_access(bsla); break;
			case 17: if (machine.evt_Sensor_detects.guard_Sensor_detects(sensor_detects))
				machine.evt_Sensor_detects.run_Sensor_detects(sensor_detects); break;
			case 18: if (machine.evt_Sensor_stops_detecting.guard_Sensor_stops_detecting(sensor_stops))
				machine.evt_Sensor_stops_detecting.run_Sensor_stops_detecting(sensor_stops); break;
			}
			capacities = null; //not supported yet
			vehicle_id_board = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));
			vehicle_type_board = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));
			vehicle_id_unboard = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));
			vehicle_type_unboard = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));
			position_q_unboard = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));
			position_s_unboard = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));
			selected_level = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));
			vehicle_id_boardlift = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));
			vehicle_type_boardlift = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));
			position_q_boardlift = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));
			position_s_boardlift = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));
			vehicle_id_leave_lift = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));
			vehicle_type_leave_lift = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));
			floor = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));
			vehicle_type_reserve = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));
			vehicle_id_auth = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));
			vehicle_type_auth = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));
			is_left = Utilities.someVal(new BSet<Boolean>(true,false));
			queue_1_in = Utilities.someVal(new BSet<Boolean>(true,false));
			queue_2_in = Utilities.someVal(new BSet<Boolean>(true,false));
			queue_1_out = Utilities.someVal(new BSet<Boolean>(true,false));
			queue_2_out = Utilities.someVal(new BSet<Boolean>(true,false));
			bsli = Utilities.someVal(new BSet<Boolean>(true,false));
			bslo = Utilities.someVal(new BSet<Boolean>(true,false));
			bs1a = Utilities.someVal(new BSet<Boolean>(true,false));
			bs2a = Utilities.someVal(new BSet<Boolean>(true,false));
			bs3a = Utilities.someVal(new BSet<Boolean>(true,false));
			bsla = Utilities.someVal(new BSet<Boolean>(true,false));
			sensor_detects = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));
			sensor_stops = Utilities.someVal(new BSet<Integer>((new Enumerated(1,Utilities.max_integer))));
		}
	}

}
