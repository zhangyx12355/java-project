/**
 * test
 */
public class test {

    public static void main(String[] args) {
        QuickSort qSort = new QuickSort();
        int[] array = new int[]{3,8,1,2};
        qSort.quicksort(array, 0, 3);
        for (int i : array) {
            System.out.println(i);
        }
        
    }
}