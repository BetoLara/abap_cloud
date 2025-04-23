@AbapCatalog.sqlViewName: 'ZHLL_V_CUSTOMER'
@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Customers'
@Metadata.ignorePropagatedAnnotations: true
@UI.headerInfo:{typeName: 'Customer',
typeNamePlural: 'Customers', imageUrl: 'Url'} 
define root view ZHLL_CDS_CUSTOMER as select from zhll_customer
{
    @UI.facet: [ { id:              'Customer',
                   purpose:         #STANDARD,
                   type:            #IDENTIFICATION_REFERENCE,
                   label:           'Customer',
                   position:        10 } ]
                     
    @UI.lineItem:[{position: 10, label: 'Customer ID'}]
    @UI.identification: [{position: 10, importance: #HIGH}]
    key customer as Customer,
    @UI.lineItem:[{position: 20, label: 'First Name'}]
    @UI.identification: [{position: 20, importance: #HIGH}]
    name as Name,
    @UI.lineItem:[{position: 30, label: 'Status', criticality: 'Status'}]
    @UI.identification: [{position: 30, importance: #HIGH, criticality: 'Status'}]
    status as Status,
    
    @UI.hidden: true
    url as Url 
}
