/* janusgraph-schema.groovy
 *
 * Helper functions for declaring JanusGraph schema elements
 * (vertex labels, edge labels, property keys) to accommodate
 * TP3 sample data.
 *
 * Sample usage in a gremlin.sh session:
 *
 * gremlin> :load data/janusgraph-schema-grateful-dead.groovy
 * ==>true
 * ==>true
 * gremlin> t = JanusGraphFactory.open('conf/janusgraph-cassandra.properties')
 * ==>standardjanusgraph[cassandrathrift:[127.0.0.1]]
 * gremlin> defineGratefulDeadSchema(t)
 * ==>null
 * gremlin> t.close()
 * ==>null
 * gremlin>
 */

def defineCciDataSchema(janusGraph) {
    m = janusGraph.openManagement()
    // vertex labels
    idCard = m.makeVertexLabel("idCard").make() // personid
    home  = m.makeVertexLabel("home").make() // home tel
    phone   = m.makeVertexLabel("phone").make() // mobile_tel
    landLine   = m.makeVertexLabel("landLine").make() // landLine
    account = m.makeVertexLabel("account").make() // account
    companyLine = m.makeVertexLabel("companyLine").make() // companyLine
    fingerprint = m.makeVertexLabel("fingerprint").make() // fingerprint
    bankCard = m.makeVertexLabel("bankCard").make() // bankCard
    ip = m.makeVertexLabel("ip").make() // ip
    // edge labels
    idlandline     = m.makeEdgeLabel("id-land_line").make()
    idaccount  = m.makeEdgeLabel("id-account").make()
    idphone = m.makeEdgeLabel("id-phone").make()
    idhome = m.makeEdgeLabel("id-home").make()

    idcompanyLine = m.makeEdgeLabel("id-companyLine").make()
    idfingerprint = m.makeEdgeLabel("id-fingerprint").make()
    idbankCard = m.makeEdgeLabel("id-bankCard").make()
    idip = m.makeEdgeLabel("id-ip").make()
    
    // vertex and edge properties
    blid         = m.makePropertyKey("bulkLoader.vertex.id").dataType(String.class).make()
    name         = m.makePropertyKey("name").dataType(String.class).make()
    created = m.makePropertyKey("created").dataType(String.class).make()
    // global indices
    m.buildIndex("byBulkLoaderVertexId", Vertex.class).addKey(blid).buildCompositeIndex()

    m.buildIndex("idCardById", Vertex.class).addKey(name).indexOnly(idCard).buildCompositeIndex()
    
    m.buildIndex("homeById", Vertex.class).addKey(name).indexOnly(home).buildCompositeIndex()

    m.buildIndex("phoneById", Vertex.class).addKey(name).indexOnly(phone).buildCompositeIndex()

    m.buildIndex("landLineById", Vertex.class).addKey(name).indexOnly(landLine).buildCompositeIndex()

    m.buildIndex("accountById", Vertex.class).addKey(name).indexOnly(account).buildCompositeIndex()

    m.buildIndex("companyLineById", Vertex.class).addKey(name).indexOnly(companyLine).buildCompositeIndex()
    m.buildIndex("bankCardById", Vertex.class).addKey(name).indexOnly(bankCard).buildCompositeIndex()
    m.buildIndex("fingerprintById", Vertex.class).addKey(name).indexOnly(fingerprint).buildCompositeIndex()
    m.buildIndex("ipById", Vertex.class).addKey(name).indexOnly(ip).buildCompositeIndex()



    // vertex centric indices
    m.buildEdgeIndex(idlandline, "idlandlinebyCreated", Direction.BOTH, Order.decr, created)
    m.buildEdgeIndex(idaccount, "idaccountbyCreated", Direction.BOTH, Order.decr, created)
    m.buildEdgeIndex(idphone, "idphonebyCreated", Direction.BOTH, Order.decr, created)
    m.buildEdgeIndex(idhome, "idhomebyCreated", Direction.BOTH, Order.decr, created)
    m.buildEdgeIndex(idcompanyLine, "idcompanyLinebyCreated", Direction.BOTH, Order.decr, created)
    m.buildEdgeIndex(idfingerprint, "idfingerprintbyCreated", Direction.BOTH, Order.decr, created)
    m.buildEdgeIndex(idbankCard, "idbankCardbyCreated", Direction.BOTH, Order.decr, created)
    m.buildEdgeIndex(idip, "idipCreated", Direction.BOTH, Order.decr, created)

    m.commit()
}

graph = JanusGraphFactory.open("conf/janusgraph-hbase-es.properties")
defineCciDataSchema(graph)
