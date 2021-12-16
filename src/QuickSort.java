public class QuickSort {
    public void quicksort(int[] array,int low,int high){
        if (low > high) {
            return;
        }
        int i,j,temp,t;
        i = low;
        j = high;
        temp = array[low];
        while (i < j) {
            while (temp <= array[j] && i<j) {
                j--;
            }
            while (temp >= array[i] && i<j) {
                i++;
            }
            if(i<j){
                t = array[i];
                array[i] = array[j];
                array[j] = t;
            }
        }
        array[low]  = array[i];
        array[i] = temp;

        quicksort(array, low, j-1);
        quicksort(array, j+1, high);
    }
}
