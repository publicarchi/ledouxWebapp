xquery version "3.1";
module namespace ledoux.ledoux = "ledoux.ledoux";
(:~
 : This xquery module is an application for xpr
 :
 : @author emchateau & carolineCorbieres
 : @since 2021-05
 : @licence GNU http://www.gnu.org/licenses
 : @version 0.1
 :
 : LedouxApp is free software: you can redistribute it and/or modify
 : it under the terms of the GNU General Public License as published by
 : the Free Software Foundation, either version 3 of the License, or
 : (at your option) any later version.
 :
 :)

import module namespace G = 'ledoux.globals' at './globals.xqm' ;
(:
import module namespace ledoux.mappings.html = 'ledoux.mappings.html' at './mappings.html.xqm' ;
:)
import module namespace ledoux.models.ledoux = 'ledoux.models.ledoux' at './models.ledoux.xqm' ;

import module namespace Session = 'http://basex.org/modules/session';

declare namespace rest = "http://exquery.org/ns/restxq" ;
declare namespace file = "http://expath.org/ns/file" ;
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization" ;
declare namespace db = "http://basex.org/modules/db" ;
declare namespace web = "http://basex.org/modules/web" ;
declare namespace update = "http://basex.org/modules/update" ;
declare namespace perm = "http://basex.org/modules/perm" ;
declare namespace user = "http://basex.org/modules/user" ;
declare namespace session = 'http://basex.org/modules/session' ;
declare namespace http = "http://expath.org/ns/http-client" ;

declare namespace tei = "http://www.tei-c.org/ns/1.0" ;

declare namespace ev = "http://www.w3.org/2001/xml-events" ;
declare namespace map = "http://www.w3.org/2005/xpath-functions/map" ;
declare namespace xf = "http://www.w3.org/2002/xforms" ;
declare namespace xlink = "http://www.w3.org/1999/xlink" ;

declare namespace ledoux = "ledoux" ;
declare default element namespace "http://www.tei-c.org/ns/1.0" ;
declare default function namespace "ledoux.ledoux" ;

declare default collation "http://basex.org/collation?lang=fr" ;

(:~
 : This resource function defines the application home
 : @return redirect to the ressource
 :)
declare
  %rest:path("/ledoux/home")
  %output:method("xml")
function home() {
  web:redirect("/ledoux/buildings")
};

(:~
 : This resource function lists all the buildings
 : @return an ordered list of buildings in xml
 :)
declare
  %rest:path("/ledoux/buildings")
  %rest:produces('application/xml')
  %output:method("xml")
function getBuildings() {
  db:open('ledoux')//listObject[@type="buildings"]
};

(:~
 : This resource function create a new item
 : @return @todo
 :)
declare
  %rest:path("/ledoux/building/put")
  %rest:produces('application/xml')
  %rest:header-param("Referer", "{$referer}", "none")
  %rest:PUT("{$param}")
  %output:method("xml")
  %updating
function putBuilding($param, $referer) {
  let $db := db:open('ledoux')
  let $id := $param/*/@xml:id
  return
    replace node $db//listObject[@type='buildings']/object[@xml:id = $id] with $param,
    update:output(
     (
          <rest:response>
            <http:response status="200" message="test">
              <http:header name="Content-Language" value="fr"/>
              <http:header name="Content-Type" value="text/plain; charset=utf-8"/>
            </http:response>
          </rest:response>,
          <result>
            <id>{'$id'}</id>
            <message>La ressource a été modifiée.</message>
            <url></url>
          </result>
         )
        )
};

(:~
 : This resource function return a building item
 : @return a building item in xml
 :)
declare
  %rest:path("/ledoux/building/{$id}")
  %rest:produces('application/xml')
  %output:method("xml")
function getBuilding($id) {
 db:open('ledoux')//object[@xml:id = $id]
};

(:~
 : This resource function modify an expertise item
 : @param $id the expertise id
 : @return an xforms to edit the expertise
 :)
declare
  %rest:path("ledoux/building/{$id}/modify")
  %output:method("xml")
  (: %perm:allow("expertises") :)
function modifyBuilding($id) {
  let $content := map {
    'instance' : $id,
    'path' : 'building',
    'model' : 'ledouxBuildingModel.xml',
    'trigger' : 'ledouxBuildingTrigger.xml',
    'form' : 'ledouxBuildingForm.xml'
  }
  let $outputParam := map {
    'layout' : "template.xml"
  }
  return
    (processing-instruction xml-stylesheet { fn:concat("href='", $G:xsltFormsPath, "'"), "type='text/xsl'"},
    <?css-conversion no?>,
    ledoux.models.ledoux:wrapper($content, $outputParam)
    )
};

(:~
 : This resource function lists all the works
 : @return an ordered list of works in xml
 :)

 (:~
  : This resource function lists all the plates
  : @return an ordered list of plates in xml
  :)