local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
    s("c:out", fmt([[
<c:out value="{}"/>
    ]], { i(1, "value") })),
    s("c:set", fmt([[
<c:set var="{}" value="{}" scope="{}"/>
    ]], { i(1, "var"), i(2, "value"), i(3, "scope") })),
    s("c:if", fmt([[
<c:if test="{}">
    {}
</c:if>
    ]], { i(1, "condition"), i(2, "body") })),
    s("c:choose", fmt([[
<c:choose>
    <c:when test="{}">
        {}
    </c:when>
    <c:otherwise>
        {}
    </c:otherwise>
</c:choose>
    ]], { i(1, "condition"), i(2, "when body"), i(3, "otherwise body") })),
    s("c:forEach", fmt([[
<c:forEach var="{}" items="{}">
    {}
</c:forEach>
    ]], { i(1, "var"), i(2, "items"), i(3, "body") })),
    s("c:url", fmt([[
<c:url value="{}" var="{}" scope="{}"/>
    ]], { i(1, "value"), i(2, "var"), i(3, "scope") })),
    s("c:import", fmt([[
<c:import url="{}" var="{}" scope="{}"/>
    ]], { i(1, "url"), i(2, "var"), i(3, "scope") })),
    s("c:param", fmt([[
<c:param name="{}" value="{}"/>
    ]], { i(1, "name"), i(2, "value") })),

    s("fmt:formatDate", fmt([[
<fmt:formatDate value="{}" pattern="{}"/>
    ]], { i(1, "date"), i(2, "pattern") })),
    s("fmt:formatNumber", fmt([[
<fmt:formatNumber value="{}" pattern="{}"/>
    ]], { i(1, "number"), i(2, "pattern") })),

    s("sql:query", fmt([[
<sql:query var="{}" dataSource="{}">
    {}
</sql:query>
    ]], { i(1, "var"), i(2, "dataSource"), i(3, "sql") })),
    s("sql:update", fmt([[
<sql:update var="{}" dataSource="{}">
    {}
</sql:update>
    ]], { i(1, "var"), i(2, "dataSource"), i(3, "sql") })),

    s("x:parse", fmt([[
<x:parse var="{}" doc="{}"/>
    ]], { i(1, "var"), i(2, "doc") })),
    s("x:out", fmt([[
<x:out select="{}"/>
    ]], { i(1, "xpath") })),
}
