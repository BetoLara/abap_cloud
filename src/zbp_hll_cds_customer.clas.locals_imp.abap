CLASS lhc_ZHLL_CDS_CUSTOMER DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zhll_cds_customer RESULT result.

ENDCLASS.

CLASS lhc_ZHLL_CDS_CUSTOMER IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

ENDCLASS.
