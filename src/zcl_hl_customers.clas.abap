CLASS zcl_hl_customers DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_hl_customers IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

      DATA itab TYPE TABLE OF zhll_customer.

      itab = VALUE #(
          ( customer = '1' name = 'Suzana' )
          ( customer = '2' name = 'Heriberto' )
          ( customer = '3' name = 'Dalia' )
        ).

      INSERT zhll_customer FROM TABLE @itab.
      out->write( |{ sy-dbcnt } customers inserted successfully!| ).
  ENDMETHOD.

ENDCLASS.
