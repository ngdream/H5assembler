#include "h5mparse.hxx"
#include "h5mlex.hpp"

using namespace std;

int runwithoutarg(char **argv)
{
    FILE *maker = fopen("h5maker", "r");
    yyin = maker;
    yyparse();
    return EXIT_SUCCESS;
}
