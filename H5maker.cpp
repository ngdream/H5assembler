#include "h5mparse.hxx"
#include "h5mlex.hpp"
#include <iostream>
using namespace std;

int runwithoutarg(char **argv)
{
    FILE *maker = fopen("h5maker", "r");
    if (maker)
    {
        yyin = maker;
        yyparse();
        fclose(maker);
        return EXIT_SUCCESS;
    }
    return EXIT_FAILURE;
}

int compilewithh5m(char **argv, int argc)
{
    int mk = 0;
    for (int i = 2; i < argc; i++)
    {
        FILE *maker = fopen(argv[i], "r");
        if (maker)
        {
            yyin = maker;
            yyparse();
            fclose(maker);
            mk++;
        }
        else
        {
            cout << "cannot find maker file :" << argv[i] << endl;
        }
    }
    return (mk) ? EXIT_SUCCESS : EXIT_FAILURE;
}