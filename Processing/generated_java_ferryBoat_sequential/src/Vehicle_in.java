public class Vehicle_in{
	/*@ spec_public */ private fifthRef machine; // reference to the machine 

	/*@ public normal_behavior
		requires true;
		assignable \everything;
		ensures this.machine == m; */
	public Vehicle_in(fifthRef m) {
		this.machine = m;
	}

	/*@ public normal_behavior
		requires true;
 		assignable \nothing;
		ensures \result <==> (BOOL.instance.has(queue_1) && BOOL.instance.has(queue_2) && new BSet<Boolean>(queue_1,queue_2).has(true) && ((!queue_1.equals(machine.get_queue1())) ==> (queue_1.equals(true))) && ((!queue_2.equals(machine.get_queue2())) ==> (queue_2.equals(true))) && !new BSet<Boolean>(queue_1,queue_2).equals(new BSet<Boolean>(machine.get_queue1(),machine.get_queue2()))); */
	public /*@ pure */ boolean guard_Vehicle_in( Boolean queue_1, Boolean queue_2) {
		return (BOOL.instance.has(queue_1) //type check, header checks anyway..
				&& BOOL.instance.has(queue_2) 
				
				&& new BSet<Boolean>(queue_1,queue_2).has(true) //at least 1 true
				
				&& BOOL.implication(!queue_1.equals(machine.get_queue1()),queue_1.equals(true))//if new value, then value is true
				&& BOOL.implication(!queue_2.equals(machine.get_queue2()),queue_2.equals(true)) 
				
				&& !new BSet<Boolean>(queue_1,queue_2).equals(new BSet<Boolean>(machine.get_queue1(),machine.get_queue2()))); //values change
	}

	/*@ public normal_behavior
		requires guard_Vehicle_in(queue_1,queue_2);
		assignable machine.queue1, machine.queue2;
		ensures guard_Vehicle_in(queue_1,queue_2) &&  machine.get_queue1() == \old(queue_1) &&  machine.get_queue2() == \old(queue_2); 
	 also
		requires !guard_Vehicle_in(queue_1,queue_2);
		assignable \nothing;
		ensures true; */
	public void run_Vehicle_in( Boolean queue_1, Boolean queue_2){
		if(guard_Vehicle_in(queue_1,queue_2)) {
			Boolean queue1_tmp = machine.get_queue1();
			Boolean queue2_tmp = machine.get_queue2();

			machine.set_queue1(queue_1);
			machine.set_queue2(queue_2);

			System.out.println("Vehicle_in executed queue_1: " + queue_1 + " queue_2: " + queue_2 + " ");
		}
	}

}
