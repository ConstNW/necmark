/**
 * ...
 * @author Const
 */
import tink.unit.*;
import tink.testrunner.*;

class Main
{
    static function main( )
    {
        Runner.run(TestBatch.make([
            new cases.Version(),
            new cases.Html(),
            new cases.Xml(),
            new cases.Man(),
            new cases.Latex(),
            new cases.CommonMark(),
        ])).handle(Runner.exit);
    }
}