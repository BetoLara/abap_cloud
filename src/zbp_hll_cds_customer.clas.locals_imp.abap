CLASS lsc_zhll_cds_customer DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS adjust_numbers REDEFINITION.

ENDCLASS.

CLASS lsc_zhll_cds_customer IMPLEMENTATION.

  METHOD adjust_numbers.
    IF mapped-customers IS NOT INITIAL.

        SELECT MAX( customer ) FROM zhll_customer INTO @DATA(lv_customer).

        DATA(ls_mapped) = VALUE #( mapped-customers[ 1 ] OPTIONAL ).
        ls_mapped-customer = lv_customer + 1.

        APPEND CORRESPONDING #( ls_mapped ) TO mapped-customers.
    ENDIF.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZHLL_CDS_CUSTOMER DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Customers RESULT result.
    METHODS mcustomer FOR DETERMINE ON SAVE
      IMPORTING keys FOR Customers~mcustomer.

ENDCLASS.

CLASS lhc_ZHLL_CDS_CUSTOMER IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD mcustomer.
    DATA update TYPE TABLE FOR CREATE zhll_cds_customer.

    " Select max Customer ID
    SELECT SINGLE
        FROM zhll_cds_customer
        FIELDS MAX( customer ) AS CustomerID
        INTO @DATA(max_customerid).

    " check if TravelID is already filled
    READ ENTITIES OF zhll_cds_customer IN LOCAL MODE
      ENTITY Customers
        ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(clientes).

    " Set the Customer ID
    LOOP AT clientes INTO DATA(cliente).
      " Clear state messages that might exist
      APPEND VALUE #(  %cid = '1'
                       customer     = 4
                       name        = cliente-name
                       %control-customer = if_abap_behv=>mk-on
                       %control-name = if_abap_behv=>mk-on )
        TO update.
    ENDLOOP.

*    MODIFY ENTITIES OF zhll_cds_customer IN LOCAL MODE
*    ENTITY Customers
*      DELETE FROM VALUE #( (  %tky = cliente-%tky ) ).
*
*    MODIFY ENTITIES OF zhll_cds_customer IN LOCAL MODE
*    ENTITY Customers
*      CREATE FROM update
*      MAPPED DATA(lt_data).

  ENDMETHOD.
ENDCLASS.
