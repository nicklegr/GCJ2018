#include <stdio.h>
#include <string.h>

int main()
{
    int t, a, b, n;
    scanf("%d", &t);

    for (int i = 0; i < t; ++i)
    {
        scanf("%d %d", &a, &b);
        scanf("%d", &n);

        int low = a + 1;
        int hi = b;
        int guess = (low + hi) / 2;

        bool success = false;
        for (int j = 0; j < n; ++j)
        {
            printf("%d\n", guess);
            fflush(stdout);

            char res[100];
            scanf("%s", res);

            if (strcmp(res, "CORRECT") == 0)
            {
                success = true;
                break;
            }
            else if (strcmp(res, "TOO_SMALL") == 0)
            {
                low = guess + 1;
            }
            else if (strcmp(res, "TOO_BIG") == 0)
            {
                hi = guess - 1;
            }
            else if (strcmp(res, "WRONG_ANSWER") == 0)
            {
                return 1;
            }

            guess = (low + hi) / 2;
        }

        if (!success)
        {
            return 1;
        }
    }
}
