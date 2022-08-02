typedef void *yyscan_t;

#include "h5parse.hxx"
#include "h5lex.hpp"

#include <iostream>
#include <fstream>
using namespace std;

extern string initialdata;
extern string pdata;
extern bool loop;
extern string basedir;

string compile(string content);
string compilefile(string path);
int runwithargs(int argc, char **argv);
int runwithoutarg(char **argv);
int saveoutput(string compileddata, string outputpath = "");
// our main function
int main(int argc, char **argv)
{

    int c = (argc > 1) ? runwithargs(argc, argv) : runwithoutarg(argv); // if there are arguments run with them
    system("pause");                                                    // don't quit the app at the end of assembly
    return (c);
}

// run h5A by using  arguments
int runwithargs(int argc, char **argv)
{
    if (argv[2] == "-m")
    {
        if (argc < 3)
        {
            // will assemble a file using a H5maker file
            cout << "no H5maker file specified" << endl;
        }
    }
    else
    {
        if (argc > 2)
        {
            for (int i = 2; i < argc; i++)
                saveoutput(compilefile(argv[1]), argv[i]);
        }
        else
            saveoutput(compilefile(argv[1]));
    }

    return EXIT_SUCCESS;
}

// assemble a string
string compile(string content)
{

    do
    {

        loop = false;
        yyscan_t *scan = new yyscan_t;
        pdata.clear();

        yylex_init(scan);
        YY_BUFFER_STATE buf = yy_scan_bytes(content.c_str(), strlen(content.c_str()), *scan);
        yyparse(*scan);
        yylex_destroy(*scan);
        content = pdata;

    } while (loop == true);
    return content;
}

// assemble file
string compilefile(string path)
{
    string data;
    ifstream inputfile(path, ios::in | ios::binary | ios::ate);
    int length = inputfile.tellg();
    inputfile.seekg(0, std::ios::beg);
    char *buffer = new char[length]; // allocate memory for a buffer of appropriate dimension
    inputfile.read(buffer, length);  // read the whole file into the buffer
    inputfile.close();
    cout << "start assembly : " << path << endl;

    const size_t last_slash_idx = path.rfind('\\');
    if (std::string::npos != last_slash_idx)
    {
        basedir = path.substr(0, last_slash_idx);
    }
    cout << "directory is :" << basedir << endl;
    return compile(string(buffer));
}

// save  assembled  file to a specified path
int saveoutput(string compileddata, string outputpath)
{

    outputpath = (outputpath == "") ? "output.html" : outputpath;
    ofstream outputfile(outputpath);
    outputfile << compileddata;
    cout << "\noperation terminated successfuly , output at :"
         << outputpath << endl;

    return 0;
}
