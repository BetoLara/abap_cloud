@AbapCatalog.sqlViewName: 'ZHLL_V_CUSTOMER'
@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Customers'
@Metadata.ignorePropagatedAnnotations: true
@UI.headerInfo:{typeName: 'Customer',
typeNamePlural: 'Customers', imageUrl: 'Url'} 
define root view ZHLL_CDS_CUSTOMER as select from zhll_customer as customer
//association [0..*] to ZHLL_CDS_CUSTPO as _custpo on $projection.Customer = _custpo.Customer
composition [0..*] of ZHLL_CDS_CUSTPO as _custpo 
{
    @UI.facet: [ { id:              'Customer',
                   purpose:         #STANDARD,
                   type:            #IDENTIFICATION_REFERENCE,
                   label:           'Customer',
                   position:        10 } ,
                 { id:            'POs',
                 purpose:         #STANDARD,
                 type:            #LINEITEM_REFERENCE,
                 label:           'POs',
                 position:        20,
                 targetElement:   '_custpo'} ]  
                     
    @UI.lineItem:[{position: 10, label: 'Customer ID'}]
    @UI.identification: [{position: 10, importance: #HIGH}]
    key customer as Customer,
    @UI.lineItem:[{position: 20, label: 'First Name'}]
    @UI.identification: [{position: 20, importance: #HIGH}]
    name as Name,
    @UI.lineItem:[{position: 30, label: 'Status'},
    { type: #FOR_ACTION, dataAction: 'changeStatus', label: 'Change' }]
    @UI.identification: [{position: 30, criticality: 'Status'},
    { type: #FOR_ACTION, dataAction: 'changeStatus', label: 'Change' }]
    status as Status,
//    @UI: { lineItem:       [ { position: 40},
//                            { type: #FOR_ACTION, dataAction: 'changeStatus', label: 'Change' }                            
//                          ],
//          identification: [ { position: 40},
//                            { type: #FOR_ACTION, dataAction: 'changeStatus', label: 'Change' }                            
//                          ] } 
//    status,
    @UI.hidden: true
    url as Url, 
    
    /* associations */
    _custpo    
}
