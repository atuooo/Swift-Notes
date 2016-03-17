//
//  C Pointer 
//
//  from: http://denniskubes.com/2012/08/16/the-5-minute-guide-to-c-pointers/
//    cn: http://blog.jobbole.com/25409/
//
//  Created by Atuooo on 8/19/15.
//  Copyright © 2015 atuooo. All rights reserved.
//

#include <stdio.h>

int main(int argc, const char * argv[]) {
    
    // declare an variable ptr which holds the value-at-address of an int type
    int *ptr;
    // declare assign an int the literal value of 1
    int val = 1;
    // assign to ptr the address-of the val variable
    ptr = &val;
    // dereference and get the value-at-address stored in ptr
    int deref = *ptr;
    printf("%d\n", deref); // deref = *ptr = *(&val) = 1
    
    /**
     *  A pointer can be declared to be a void type. 
        A pointer can be set to NULL or 0.  
        A pointer variable that has been declared but not yet assigned a value is considered uninitialized.
     */

    int *uninit; // leave the int pointer uninitialized
    int *nullptr = NULL; // initialized to 0, could also be NULL
    void *vptr; // declare as a void pointer type
    int *iptr;
    int *backptr;
    
    // void type can hold any pointer type or reference
    iptr = &val;
    vptr = iptr;
    printf("iptr = %p, vptr = %p\n", (void *)iptr, vptr);   // iptr = 0x7fff5fbff7b4 = vptr = 0x7fff5fbff7b4
    // assign void pointer back to an int pointer and dereference
    backptr = vptr;
    printf("*backptr = %d\n", *backptr);    // *backptr = 1
    
    /**
        Notice that our uninitialized pointer has a memory location. This is a garbage location.
        Any variable that is declared but not initialized will have a garbage memory location. Pointers are no exception.
        There is no telling what is at that location in memory.
        This is the reason why you should never try to dereference an uninitialized pointer.
        Best case you get garbage back and you have a fun time trying to debug your program.
        Worst case the program crashes badly
     */
    printf("uninit = %p, nullptr = %p\n", uninit, (void *)nullptr); // uninit = 0x0, nullptr = 0x0
    /// don't know what you will get back, random garbage?
    // printf("*nullptr=%d\n", nullptr);
    /// will cause a segmentation fault
    // printf("*nullptr=%d\n", nullptr);    return 0;
    
    /**
     *  Pointers and Arrays
     */
    
    int myarray[4] = {1,2,3,0};
    int *ptrOfArray = myarray;
    printf("*ptrOfArray = %d\n", *ptrOfArray);  // *ptrOfArray = 1

    /// cannot do this, array variables are constant
    // myarray = ptr
    // myarray = myarray2
    // myarray = &myarray2[0]
    
    /**
     *  Pointers and Structs
     */

    struct person {
        int age;
        char *name;
    };
    struct person first;
    struct person *ptrOfPerson;
    
    first.age = 21;
    char *fullname = "full name";
    first.name = fullname;
    ptrOfPerson = &first;

    /**
     With the age field we are accessing the struct instance directly and so we use the . notation. 
     With the name field we are using our pointer to the struct instance and so we use the -> notation.
     */
    printf("age = %d, name = %s\n", (*ptrOfPerson).age, ptrOfPerson->name);  // age = 21, name = full name
    
    /**
     *  Pointers to Pointers
     */
    
    int val_x = 1;
    int *ptr_x = 0;
    // declare a variable ptr2ptr which holds the value-at-address of
    // an *int type which in holds the value-at-address of an int type
    int **ptr2ptr = 0;
    ptr_x = &val;
    ptr2ptr = &ptr_x;
    
    printf("&ptr_x = %p, &val_x = %p\n", (void *)&ptr_x, (void *)&val_x);
    // &ptr_x = 0x7fff5fbff730, &val_x = 0x7fff5fbff73c
    
    printf("ptr2ptr = %p, *ptr2ptr = %p, **ptr2ptr = %d\n", (void *)ptr2ptr, (void *)*ptr2ptr, **ptr2ptr);
    //ptr2ptr = 0x7fff5fbff730, *ptr2ptr = 0x7fff5fbff794, **ptr2ptr = 1

}
