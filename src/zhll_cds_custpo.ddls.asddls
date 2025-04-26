@AbapCatalog.sqlViewName: 'ZHLL_V_CUSTPO'
@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Customers PO'
@Metadata.ignorePropagatedAnnotations: true
define view ZHLL_CDS_CUSTPO as select from zhll_custpo as custpo
//association [1..1] to ZHLL_CDS_CUSTOMER as _customer on $projection.Customer = _customer.Customer
association to parent ZHLL_CDS_CUSTOMER as _customer on  $projection.Customer = _customer.Customer 
 {
 
    @UI.facet: [ { id:              'POs',
                   purpose:         #STANDARD,
                   type:            #IDENTIFICATION_REFERENCE,
                   label:           'POs',
                   position:        10 } ]
                   
    @UI.lineItem:[{position: 10, label: 'Customer ID'}]
    @UI.identification: [{position: 10, importance: #HIGH}]
    key customer as Customer,
    @UI.lineItem:[{position: 20, label: 'PO Number'}]
    @UI.identification: [{position: 20, importance: #HIGH}]
    key ponumber as Ponumber,
    @UI.lineItem:[{position: 30, label: 'Material'}]
    @UI.identification: [{position: 30, importance: #HIGH}]    
    material as Material,
     @UI.lineItem:[{position: 40, label: 'Precio'},
    { type: #FOR_ACTION, dataAction: 'changePrecio', label: 'Precio' }]
    @UI.identification: [{position: 40},
    { type: #FOR_ACTION, dataAction: 'changePrecio', label: 'Precio' }]
    costo as Costo,
    
    /* associations */
    _customer      
}
