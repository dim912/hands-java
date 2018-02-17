package org.behavioral;

import java.util.Stack;

/**
 * Intepreter Pattern
 * 1) Defines grammatical representation of a language
 * 2) And provide an interpreter to deal with grammar and read a sentence.
 * <p>
 * Ex: Translator, Reading musical notes and playing
 * <p>
 * Citizens
 * <p>
 * 1) Context => Global info of the interpreter
 * 2) AbstractExpression =. interface fr executing operations
 * 3) TerminalExpression
 * 4) Client
 * 5) NonTerminalExpression
 * <p>
 *     Advantages
 *     -----------
 * * Decouples expressions from grammar
 *
 * When to use.
 * 1) Grammar can be represented as a syntax tree
 * 2) Grammar is simple
 * 3) Efficiency is not a problem
 * 4) Grammar to expression decoupling is needed
 *
 */
public class IntepreterTest {

    public static void main(String[] args) {

        String tokenString = "7 3 - 2 1 + *";
        Stack<Expression> stack = new Stack<>();
        String[] tokenArray = tokenString.split(" ");
        for (String s : tokenArray) {
            if (ExpressionUtils.isOperator(s)) {
                Expression rightExpression = stack.pop();
                Expression leftExpression = stack.pop();
                Expression operator = ExpressionUtils.getOperator(s, leftExpression, rightExpression);
                int result = operator.interpret();
                stack.push(new Number(result));
            } else {
                Expression i = new Number(Integer.parseInt(s));
                stack.push(i);
            }
        }
        System.out.println("( " + tokenString + " ): " + stack.pop().interpret());

    }


}

interface Expression {
    int interpret();
}

class Add implements Expression {
    private final Expression leftExpression;
    private final Expression rightExpression;

    public Add(Expression leftExpression, Expression rightExpression) {
        this.leftExpression = leftExpression;
        this.rightExpression = rightExpression;
    }

    @Override
    public int interpret() {
        return leftExpression.interpret() + rightExpression.interpret();
    }
}

class Product implements Expression {

    private final Expression leftExpression;
    private final Expression rightExpression;

    public Product(Expression leftExpression, Expression rightExpression) {
        this.leftExpression = leftExpression;
        this.rightExpression = rightExpression;
    }

    @Override
    public int interpret() {
        return leftExpression.interpret() * rightExpression.interpret();
    }
}

class Substract implements Expression {

    private final Expression leftExpression;
    private final Expression rightExpression;

    public Substract(Expression leftExpression, Expression rightExpression) {
        this.leftExpression = leftExpression;
        this.rightExpression = rightExpression;
    }

    @Override
    public int interpret() {
        return leftExpression.interpret() - rightExpression.interpret();
    }

}

class Number implements Expression {

    private final int n;

    public Number(int n) {
        this.n = n;
    }

    @Override
    public int interpret() {
        return n;
    }

}


class ExpressionUtils {

    public static boolean isOperator(String s) {
        if (s.equals("+") || s.equals("-") || s.equals("*"))
            return true;
        else
            return false;
    }

    public static Expression getOperator(String s, Expression left, Expression right) {
        switch (s) {
            case "+":
                return new Add(left, right);
            case "-":
                return new Substract(left, right);
            case "*":
                return new Product(left, right);
        }
        return null;
    }

}





