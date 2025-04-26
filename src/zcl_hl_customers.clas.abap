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

      DATA itab TYPE TABLE OF zhll_custpo.

      itab = VALUE #(
          ( customer = '2' ponumber = '1' material = 'Lapiz x' )
          ( customer = '2' ponumber = '2' material = 'Borrador 345')
          ( customer = '3' ponumber = '1' material = 'Libreta 45')
        ).

      INSERT zhll_custpo FROM TABLE @itab.
      out->write( |{ sy-dbcnt } customers inserted successfully!| ).
  ENDMETHOD.

ENDCLASS.
