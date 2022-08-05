
/*
made by elodream
H5assembler is a software made by elodream  which help  all frontend devellopper and integrator to
create a static page in html without any repetitions
it will guarantee you to be able to easily interer your frontend designs in websites

*/
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
int compilewithh5m(char **argv, int argc);
int runwithoutarg(char **argv);
int saveoutput(string compileddata, string outputpath = "");
// our main function
int main(int argc, char **argv)
{

    int c = (argc > 1) ? runwithargs(argc, argv) : runwithoutarg(argv); // if there are arguments run with them
                                                                        // don't quit the app at the end of assembly
    return (c);
}

// run h5A by using  arguments
int runwithargs(int argc, char **argv)
{
    if (string(argv[1]) == "-m")
    {
        if (argc < 3)
        {
            // will not assemble a file using a H5maker file
            cout << "no H5maker file specified" << endl;
        }
        else
        {
            compilewithh5m(argv, argc);
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
    system("pause");
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
    pdata.erase();
    return content;
}

// assemble file
string compilefile(string path)
{
    string data;
    ifstream inputfile(path, ios::in | ios::binary | ios::ate);
    if (inputfile.is_open())
    {
        int length = inputfile.tellg();
        inputfile.seekg(0, std::ios::beg);
        char *buffer = new char[length + 1]; // allocate memory for a buffer of appropriate dimension
        inputfile.read(buffer, length);      // read the whole file into the buffer
        inputfile.close();
        cout << "start assembly : " << path << endl;

        const size_t last_slash_idx = path.rfind('\\');
        if (std::string::npos != last_slash_idx)
        {
            basedir = path.substr(0, last_slash_idx);
        }
        cout << "directory is :" << basedir << endl;
        string data = buffer;
        free(buffer);
        inputfile.close();
        return compile(data);
    }
    cout << "connot find file (" << path << ")" << endl;
    return "";
}

// save  assembled  file to a specified path
int saveoutput(string compileddata, string outputpath)
{

    outputpath = (outputpath == "") ? "output.html" : outputpath;
    ofstream outputfile(outputpath, ios::out | ios::binary);
    outputfile.write(compileddata.c_str(), compileddata.size());
    cout
        << "\noperation terminated successfuly , output at :"
        << outputpath << endl;
    outputfile.close();
    return 0;
}
