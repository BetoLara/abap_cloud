*CLASS lsc_zhll_cds_customer DEFINITION INHERITING FROM cl_abap_behavior_saver.
*
*  PROTECTED SECTION.
*
*    METHODS adjust_numbers REDEFINITION.
*
*ENDCLASS.
*
*CLASS lsc_zhll_cds_customer IMPLEMENTATION.
*
*  METHOD adjust_numbers.
*    IF mapped-customers IS NOT INITIAL.
*
*        SELECT MAX( customer ) FROM zhll_customer INTO @DATA(lv_customer).
*
*        DATA(ls_mapped) = VALUE #( mapped-customers[ 1 ] OPTIONAL ).
*        ls_mapped-customer = lv_customer + 1.
*
*        APPEND CORRESPONDING #( ls_mapped ) TO mapped-customers.
*    ENDIF.
*  ENDMETHOD.
*
*ENDCLASS.

CLASS lhc_ZHLL_CDS_CUSTOMER DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Customers RESULT result.
    METHODS mcustomer FOR DETERMINE ON SAVE
      IMPORTING keys FOR Customers~mcustomer.
    METHODS changeStatus FOR MODIFY
      IMPORTING keys FOR ACTION Customers~changeStatus RESULT result.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Customers RESULT result.
    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE Customers.

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

  METHOD earlynumbering_create.
    SELECT MAX( customer ) FROM zhll_customer INTO @DATA(lv_customer).

    lv_customer = COND #( WHEN lv_customer IS NOT INITIAL THEN lv_customer + 1
                    ELSE 1 ).

    mapped-customers = VALUE #( ( %cid = entities[ 1 ]-%cid
                             customer = lv_customer ) ).
  ENDMETHOD.

  METHOD changeStatus.
  " Set the new overall status
    MODIFY ENTITIES OF zhll_cds_customer  IN LOCAL MODE
      ENTITY Customers
         UPDATE
           FIELDS ( Status )
           WITH VALUE #( FOR key IN keys
                           ( %tky   = key-%tky
                             Status = 3 ) )
      FAILED failed
      REPORTED reported.

    " Fill the response table
    READ ENTITIES OF zhll_cds_customer IN LOCAL MODE
      ENTITY Customers
        ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(customers).

    result = VALUE #( FOR customer IN customers
                        ( %tky   = customer-%tky
                          %param = customer ) ).
  ENDMETHOD.

  METHOD get_instance_features.
  " Read the customer status of the existing customers
    READ ENTITIES OF zhll_cds_customer IN LOCAL MODE
      ENTITY Customers
        FIELDS ( Status ) WITH CORRESPONDING #( keys )
      RESULT DATA(customers)
      FAILED failed.

  result =
      VALUE #(
        FOR customer IN customers
          LET is_accepted =   COND #( WHEN customer-Status = 3
                                      THEN if_abap_behv=>fc-o-disabled
                                      ELSE if_abap_behv=>fc-o-enabled  )
          IN
            ( %tky                 = customer-%tky
              %action-changeStatus = is_accepted
             ) ).

  ENDMETHOD.

ENDCLASS.
