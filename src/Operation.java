public class Operation {
    public static void main(String[] args) {
        int x = 13;
        int y = 7;
        int z = 15;
        System.out.println(x ^ y);
        System.out.println(x | y);
        System.out.println(x & y);
        int max = x > y ? (x > z ? x : z) : y;
        System.out.println(max);
        
    }
}
