// ./neo4j_six_degrees_of_myke/bin/neo4j start

MATCH (a:Artist {name: 'Relay FM'})<-[:FROM_ARTIST]-(s:Show)-[:OF_GENRE]->(g:Genre)
RETURN *

MATCH (a:Person)-[:MENTIONED_IN]->(:Episode)<-[:HAS_EPISODE]-(s:Show)-[:OF_GENRE]->(g:Genre)
WHERE a.name = 'Barack Obama'
RETURN a.name, g.name, count(s)
ORDER BY count(s) DESC


MATCH (a:Person)<-[:HAS_AUTHOR]-(:Episode)<-[:HAS_EPISODE]-(s:Show)-[:OF_GENRE]->(g:Genre)
RETURN a.name, g.name, count(s)
ORDER BY count(s) DESC



// swapi

// Finding all droids in each film
MATCH (f:Film)<-[:APPEARS_IN]-(p:Person)-[:IS_SPECIES]->(s:Species)
WHERE s.name = 'Droid'
RETURN f.title, p.name

// Using collect
MATCH (f:Film)<-[:APPEARS_IN]-(p:Person)-[:IS_SPECIES]->(s:Species)
WHERE s.name = 'Droid'
RETURN f.title, collect(p.name)

// Collecting an object
MATCH (f:Film)<-[:APPEARS_IN]-(p:Person)-[:IS_SPECIES]->(s:Species)
WHERE s.name = 'Droid'
RETURN f.title, collect({name: p.name, height: p.height})

// Loading an object's data
MATCH (f:Film)<-[:APPEARS_IN]-(p:Person)-[:IS_SPECIES]->(s:Species)
WHERE s.name = 'Droid'
OPTIONAL MATCH (p)-[:HAS_HOMEWORLD]->(home:Planet)
RETURN f.title, collect({name: p.name, height: p.height, homeworld: home.name})

// Nested objects.  Like MongoDB, but normalized:
MATCH (f:Film)<-[:APPEARS_IN]-(p:Person)-[:IS_SPECIES]->(s:Species)
WHERE s.name = 'Droid'
OPTIONAL MATCH (p)-[:HAS_HOMEWORLD]->(home:Planet)
RETURN f.title, collect({name: p.name, height: p.height, homeworld: home})




