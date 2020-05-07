package FerryBoat_multi_threaded;
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

		new fifthRef();
	}

}
