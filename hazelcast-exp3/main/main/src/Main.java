import com.hazelcast.core.Hazelcast;
import com.hazelcast.core.HazelcastInstance;
import com.hazelcast.map.IMap;

public class Main {
    public static void main(String[] args) {

        HazelcastInstance hazelcastInstance = Hazelcast.newHazelcastInstance();

        // Map oluştur veya eriş
        IMap<Integer, Person> map = hazelcastInstance.getMap("people");


        for (int i = 1; i <= 10000; i++) {
            Person person = new Person("Kişi " + i);
            map.put(i, person);
        }


        for (int i = 1; i <= 10_000; i++) {
            Person p = map.get(i);
            System.out.println(i + ": " + p.getName());
        }


        hazelcastInstance.shutdown();
    }
}
